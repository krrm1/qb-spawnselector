var legionsquare = document.getElementById("legionsquare");
var Casino = document.getElementById("casino");
var bank = document.getElementById("bank");
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
    }
});

legionsquare.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/legionsquare`);
    $(".name").html('Legion Square');
});

casino.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/casino`);
    $(".name").html('Casino');
});

bank.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/bank`);
    $(".name").html('City Bank');
});

impound.addEventListener("click", function() {
    $.post(`https://qb-spawnselector/impound`);
    $(".name").html('Impound Vehicle');
});

$(".spawn").click(function() {
    $.post(`https://qb-spawnselector/spawn`);
});

$(".lastloc").click(function() {
    $.post(`https://qb-spawnselector/lastloc`);
});