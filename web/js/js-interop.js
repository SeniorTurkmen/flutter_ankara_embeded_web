(function () {
  "use strict";
  window._stateSet = function () {
    window._stateSet = function () {
      console.log("State set called");
    };
    let appState = window._appState;

    let degerField = document.getElementById("deger");
    let updateField = function () {
      degerField.value = appState.deger;
    };

    appState.addHandler(updateField);

    updateField();

    let incrementButton = document.getElementById("increment");
    incrementButton.addEventListener("click", function () {
      appState.increment();
    });

    let decrementButton = document.getElementById("decrement");
    decrementButton.addEventListener("click", function () {
      appState.decrement();
    });

    let googleButton = document.getElementById("google");
    googleButton.addEventListener("click", function () {
      appState.setValue("google.com");
    });

    let flutterButton = document.getElementById("flutter");
    flutterButton.addEventListener("click", function () {
      appState.setValue("flutter.dev");
    });

    let navigationButton = document.getElementById("btnVisible");
    navigationButton.addEventListener("click", function () {
      let res = navigationVisibility();
      appState.setNavigationVisibility(res);
    });

    let updateNavigation = function () {
      navigationButton.value = appState.navigationText;
    };

    appState.addHandler(updateNavigation);
    updateNavigation();

    function navigationVisibility() {
      let nav = document.getElementById("nav_controls");
      if (nav.style.display === "none") {
        nav.style.display = "block";
        return true;
      } else {
        nav.style.display = "none";
        return false;
      }
    }
  };
})();
