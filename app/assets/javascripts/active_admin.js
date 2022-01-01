
//= require arctic_admin/base
//= require select2
//= require select2-full
//= require jquery
//= require jquery_ujs
//= require game_timer
//= require chartkick
//= require Chart.bundle

jQuery(function() { 
  $("#quiz_game_status, #quiz_game_city_id, #quiz_game_sponsor_id, #quiz_game_radio_station_id").select2({
    height: "1000px"
  })
  $("#user_region_id").select2()
  $("#user_province_id").select2()
  $("#user_city_id").select2()
  $("#radio_station_city_id").select2()
  $(".station_city_select").select2()
  $("#roulette_city_id").select2()
  $("#roulette_radio_station_id").select2()
  $("#roulette_dj_id").select2()
  $("#roulette_sponsor_id").select2()
  $("#roulette_city_ids").select2()
  $("#product_place_id").select2()
})


document.addEventListener("DOMContentLoaded", function() {

  $("#notify-user").on("change", (e) => {
    const checked = $("#notify-user").is(':checked')
    console.log({checked})
    if(checked){
      $("#force-update").removeClass("hide")
    }else{
      $("#force-update").addClass("hide")
    }
  })

  $("#roulette_location_restriction").on("change", (e) => {
    if($("#roulette_location_restriction").is(':checked')){
      $("#roullete_location_restriction").removeClass("hide")
    }else{
      $("#roullete_location_restriction").addClass("hide")
    }
  })
  
  initLobby()
  initLoginPageStyles()
  initDashboardStyles()
});


const initLoginPageStyles = () => {
  if(window.location.pathname === '/admin/login'){
    console.log("Login styles have been loaded")
    const loginLabel = document.querySelector("#login h2")
    loginLabel.innerHTML = `<img src="/images/icon.png" style="width: 80px; height: 80px"/>`
    const loginPageBackground = document.querySelector("#active_admin_content")
    const contentWrapper = document.querySelector("#content_wrapper")
    
    loginPageBackground.style.backgroundImage = 'linear-gradient(gray, #429FB9)'
    loginPageBackground.style.opacity = 0.95;
    contentWrapper.style.backgroundImage = "url('/images/banner1.jpg')"
    contentWrapper.style.backgroundRepeat = "no-repeat"
    contentWrapper.style.backgroundSize = "100vw 100vh"
  }
}


const initDashboardStyles = () => {
  const headerH2 = document.querySelector(".header h1")
  if(headerH2 !== null) {
      
    console.log({headerH2})
    headerH2.innerHTML = `<img src="/images/icon.png"/>`
    headerH2.querySelector("img").style.width = "50px"
    headerH2.querySelector("img").style.marginTop = "5px"
  }
}