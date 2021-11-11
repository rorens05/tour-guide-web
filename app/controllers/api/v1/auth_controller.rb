class Api::V1::AuthController < Api::V1::ApiController
  require 'open-uri'
  include ImagesHelper

  before_action :require_user_login, only: [:profile, :logout]

  def connection_test
    render json: {message: "testing"}
  end

  def login
    user = User.where(login_type: "Email").find_by(email: params[:email])
    if user.present? && user.valid_password?(params[:password])
      unless user.status == 'Active'
        render json: { message: 'Your account is inactive.' }, status: :unauthorized
        return
      end
      handle_valid_credential(user)
    else
      render json: { message: 'Log in failed! Invalid email or password.' }, status: :unauthorized
    end
  end


  def register
    user = User.new(user_params)
    user.status = "Active"
    user.login_type = "Email"
    if user.save 
      user.generate_verification_code
      if params[:image].present? 
        user.image = base64_to_file(params[:image])
        user.save
      end
      UserNotifierMailer.send_confirmation_email(user).deliver
      handle_valid_credential(user)
      
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def resend_confirmation_email
    user = User.find_by(email: params[:email])
    if user.verified_at.present?
      render json: {message: "User is already verified"}, status: :unprocessable_entity
    else
      UserNotifierMailer.send_confirmation_email(user).deliver
      render json: {message: "Email resent"}
    end
  end

  def profile
    render(
      json: session_user,
      methods: %i[image_path],
      status: :ok
    )
  end

  def logout
    user = session_user
    user.token = nil
    user.save
  end

  def verify_code
    verification_code = params[:verification_code]
    user = User.find_by(verification_code: verification_code)
    if user.present? && verification_code.present?
      user.verified_at = Date.today
      user.verification_code = nil
      user.save
      render json: user, status: :ok
    else
      render json: { message: 'No user found' }, status: :unprocessable_entity
    end
  end

  def resend_verification_code
    user = User.find_by(email: params[:email])
    if user.present?
      if user.verified_at.present?
        render json: { message: 'User was already verified' }, status: :unprocessable_entity
      else
        UserNotifierMailer.send_verification_code(user, request).deliver
        render json: { message: 'Verification code has been successfully resent!' }, status: :ok
      end
    else
      render json: { message: 'No user found' }, status: :unprocessable_entity
    end
  end

  def forgot_password
    user = User.find_by(email: params[:email])
    if user.present?
      if user.login_type != 'Email' 
        return render json: { message: "Email was used in #{user.login_type} login" }, status: :unprocessable_entity
      end
      user.generate_verification_code
      user.save(validate: false)
      UserNotifierMailer.send_verification_code(user, request).deliver
      render json: { message: 'Verification code has been successfully sent!' }, status: :ok
    else
      render json: { message: 'Email is not valid' }, status: :unprocessable_entity
    end
  end

  def resend_forgot_password_code
    user = User.find_by(email: params[:email])
    if user.present?
      if user.code_expired?
        user.generate_verification_code
        user.save(validate: false)
      end
      UserNotifierMailer.send_verification_code(user, request).deliver
      render json: { message: 'Verification code has been successfully sent!' }, status: :ok
    else
      render json: { message: 'No user found' }, status: :unprocessable_entity
    end
  end

  def verify_forgot_password_code
    verification_code = params[:verification_code]
    return render json: { message: 'Code not valid' }, status: :unprocessable_entity if verification_code.blank?
    user = User.find_by(verification_code: verification_code)
    if user.present?
      if user.code_expired?
        render json: { message: 'code expired' }, status: :unprocessable_entity
      else
        render json: { message: 'Code valid', user: user }, status: :ok
      end
    else
      render json: { message: 'Code not valid' }, status: :unprocessable_entity
    end
  end

  def change_password
    code = params[:code]
    user = User.find_by(verification_code: code)
    if user.present? && code.present?
      if user.code_expired?
        render json: { message: 'code expired' }, status: :unprocessable_entity
      else
        user.password = params[:password]
        user.verification_sent_at = nil
        user.verification_code = nil
        if user.save
          render json: user, status: :ok
        else
          render json: user.errors.full_messages, status: :unprocessable_entity
        end
      end
    else
      render json: { message: 'Code not valid' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :contact_number,
      :first_name,
      :last_name,
      :gender,
      :birthday,
      :country,
      :region_id,
      :province_id,
      :city_id,
      :password
    )
  end

  def device_info_params
    params.require(:device_info).permit(
      :manufacturer,
      :device_id,
      :device_name,
      :brand,
      :ip_address,
      :model,
      :mac_address,
      :carrier,
      :system_version,
    )
  end

  def handle_valid_credential(user)
    token = encode_token({ id: user.id, time: Time.now.to_i })
    render json: { user: user.as_json(methods: :image_path), token: token}, status: :ok
  end
end
