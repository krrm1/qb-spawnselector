var legionsquare = document.getElementById("legionsquare");
var Casino = document.getElementById("casino");
var bank = document.getElementById("bank");
var apartment = document.getElementById("apartment"); // will add soon 
var impound = document.getElementById("impound");

window.addEventListener('message', function(event) {
    let data = event.data;

    switch (data.event) {
        case 'show':
            $("body").show();
            break;

        case 'hide':
            $("body").hide();
            break;

        case 'update':
            $(".name").html(data.label);
            break;
    }
});

legionsquare.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/legionsquare`);
});

casino.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/casino`);
});

bank.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/bank`);
});

impound.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/impound`);
});

apartment.addEventListener("click", function() { // will add soon
    $.post(`https://qb-spawnselector/apartment`);
});

$(".spawn").click(function() {
    $.post(`https://qb-spawnselector/spawn`);
});

$(".lastloc").click(function() {
    $.post(`https://qb-spawnselector/lastloc`);
});