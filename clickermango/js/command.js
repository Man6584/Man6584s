var score = 0;
let pps;
const itemamount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
const cost = [15, 50, 200, 500, 1500, 3500, 5000, 12000, 25000, 100000, 250000, 500000];
const itemearnings = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var bgmusic = new Audio("../public/js/sfx/bgm.mp3");

function addscore(amount){
    score = score + amount;
    document.getElementById("point").innerHTML = score;
    var clicksound = new Audio("../public/js/sfx/popsound.wav");
    clicksound.play();
}

fetch("https://gamertocoder.garena.co.th/api/minigames")
    .then((response) => {
    if (response.status !== 200) {
        return response.status;
    }
    return response.json();
    })
    .then((data) => {
    if (typeof data == "number") {
        alert(data);
    } else {
        for (let i = 0; i < data.length; i++) {
            const currentData = data[i];
            const newListItem = document.createElement("li");
            const AmountItem = document.createElement("li");
            newListItem.classList.add("card");
            AmountItem.classList.add("current");
            newListItem.onclick = function buying(){
                var success = new Audio("../public/js/sfx/success.wav");
                var failed = new Audio("../public/js/sfx/failed.mp3");
                if (currentData.no == 1) {
                    if (score >= cost[0]){
                        score = score - cost[0];
                        itemamount[0] = itemamount[0] + 1;
                        cost[0] = Math.round(cost[0] * 1.1);
                        itemearnings[0] = itemamount[0];
                        document.getElementById("Bed Wars").innerHTML = itemamount[0];
                        document.getElementById("Bed Wars1").innerHTML = cost[0];
                        document.getElementById("Bed Wars2").innerHTML = itemearnings[0];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 2) {
                    if (score >= cost[1]){
                        score = score - cost[1];
                        itemamount[1] = itemamount[1] + 1;
                        cost[1] = Math.round(cost[1] * 1.1);
                        itemearnings[1] = itemamount[1] * 5;
                        document.getElementById("Free City").innerHTML = itemamount[1];
                        document.getElementById("Free City1").innerHTML = cost[1];
                        document.getElementById("Free City2").innerHTML = itemearnings[1];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 3) {
                    if (score >= cost[2]){
                        score = score - cost[2];
                        itemamount[2] = itemamount[2] + 1;
                        cost[2] = Math.round(cost[2] * 1.1);
                        itemearnings[2] = itemamount[2] * 15;
                        document.getElementById("Frontline").innerHTML = itemamount[2];
                        document.getElementById("Frontline1").innerHTML = cost[2];
                        document.getElementById("Frontline2").innerHTML = itemearnings[2];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 4) {
                    if (score >= cost[3]){
                        score = score - cost[3];
                        itemamount[3] = itemamount[3] + 1;
                        cost[3] = Math.round(cost[3] * 1.1);
                        itemearnings[3] = itemamount[3] * 35;
                        document.getElementById("Party Street").innerHTML = itemamount[3];
                        document.getElementById("Party Street1").innerHTML = cost[3];
                        document.getElementById("Party Street2").innerHTML = itemearnings[3];

                        success.play();
                    } else{
                        failed.play();
                    }
                };
                if (currentData.no == 5) {
                    if (score >= cost[4]){
                        score = score - cost[4];
                        itemamount[4] = itemamount[4] + 1;
                        cost[4] = Math.round(cost[4] * 1.1);
                        itemearnings[4] = itemamount[4] * 75;
                        document.getElementById("Bullets Fly").innerHTML = itemamount[4];
                        document.getElementById("Bullets Fly1").innerHTML = cost[4];
                        document.getElementById("Bullets Fly2").innerHTML = itemearnings[4];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 6) {
                    if (score >= cost[5]){
                        score = score - cost[5];
                        itemamount[5] = itemamount[5] + 1;
                        cost[5] = Math.round(cost[5] * 1.1);
                        itemearnings[5] = itemamount[5] * 150;
                        document.getElementById("Rodent Evil").innerHTML = itemamount[5];
                        document.getElementById("Rodent Evil1").innerHTML = cost[5];
                        document.getElementById("Rodent Evil2").innerHTML = itemearnings[5];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 7) {
                    if (score >= cost[6]){
                        score = score - cost[6];
                        itemamount[6] = itemamount[6] + 1;
                        cost[6] = Math.round(cost[6] * 1.1);
                        itemearnings[6] = itemamount[6] * 225;
                        document.getElementById("Jail Break").innerHTML = itemamount[6];
                        document.getElementById("Jail Break1").innerHTML = cost[6];
                        document.getElementById("Jail Break2").innerHTML = itemearnings[6];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 8) {
                    if (score >= cost[7]){
                        score = score - cost[7];
                        itemamount[7] = itemamount[7] + 1;
                        cost[7] = Math.round(cost[7] * 1.1);
                        itemearnings[7] = itemamount[7] * 450;
                        document.getElementById("Build and Shoot").innerHTML = itemamount[7];
                        document.getElementById("Build and Shoot1").innerHTML = cost[7];
                        document.getElementById("Build and Shoot2").innerHTML = itemearnings[7];

                        success.play();
                    } else{
                        failed.play();
                    }
                };
                if (currentData.no == 9) {
                    if (score >= cost[8]){
                        score = score - cost[8];
                        itemamount[8] = itemamount[8] + 1;
                        cost[8] = Math.round(cost[8] * 1.1);
                        itemearnings[8] = itemamount[8] * 1000;
                        document.getElementById("Sky Block").innerHTML = itemamount[8];
                        document.getElementById("Sky Block1").innerHTML = cost[8];
                        document.getElementById("Sky Block2").innerHTML = itemearnings[8];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 10) {
                    if (score >= cost[9]){
                        score = score - cost[9];
                        itemamount[9] = itemamount[9] + 1;
                        cost[9] = Math.round(cost[9] * 1.1);
                        itemearnings[9] = itemamount[9] * 2500;
                        document.getElementById("Egg Wark").innerHTML = itemamount[9];
                        document.getElementById("Egg Wark1").innerHTML = cost[9];
                        document.getElementById("Egg Wark2").innerHTML = itemearnings[9];

                        success.play();
                    } else{

                        failed.play();
                    }
                };
                if (currentData.no == 11) {
                    if (score >= cost[10]){
                        score = score - cost[10];
                        itemamount[10] = itemamount[10] + 1;
                        cost[10] = Math.round(cost[10] * 1.1);
                        itemearnings[10] = itemamount[10] * 5250;
                        document.getElementById("District 13").innerHTML = itemamount[10];
                        document.getElementById("District 131").innerHTML = cost[10];
                        document.getElementById("District 132").innerHTML = itemearnings[10];

                        success.play();
                    } else{
                        failed.play();
                    }
                };
                if(currentData.no == 12){
                    if (score >= cost[11]){
                        score = score - cost[11];
                        itemamount[11] = itemamount[11] + 1;
                        cost[11] = Math.round(cost[11] * 1.1);
                        itemearnings[11] = itemamount[11] * 10000;
                        document.getElementById("Night at school").innerHTML = itemamount[11];
                        document.getElementById("Night at school1").innerHTML = cost[11];
                        document.getElementById("Night at school2").innerHTML = itemearnings[11];

                        success.play();
                    } else{
                        failed.play();
                    }
                };
                pps = itemamount[0] + (itemamount[1]*5) + (itemamount[2]*15) + (itemamount[3]*35) + (itemamount[4]*75)
                + (itemamount[5]*150) + (itemamount[6]*225) + (itemamount[7]*450) + (itemamount[8]*1000) + (itemamount[9]*2500)
                + (itemamount[10]*5250) + (itemamount[11]*10000);
                document.getElementById("earning").innerHTML = pps;
                document.getElementById("point").innerHTML = score;
            };
            const genre_array = currentData.genre;
            let genre_string = genre_array[0];
            if (genre_array.length > 1) {
                for (let j = 1; j < genre_array.length; j++) {
                genre_string = genre_string + ", " + genre_array[j];
                }
            }
            const html =
            '<div class="name"> Name: ' + currentData.name + '</div>'
            + '<div class="info"><img src="' + currentData.icon + '"/>'
            + '<div class="type"> Type: <br>' + genre_string + '</div>'
            + '<div class="detail">' + currentData.description + '</div></div>'
            + '<div class="amount"> Amount: <span id="'+ currentData.name + '">' + itemamount[i] + '</span> Cost: <span id="' + currentData.name +'1">' + cost[i] + '</span></div>';
            const html1 = '<div>' + currentData.name + ': <span id="' + currentData.name + '2">' + itemearnings[i] + '</span> PPS</div>';
            html.trim();
            html1.trim();
            newListItem.innerHTML = html;
            AmountItem.innerHTML = html1;
            document.getElementById("list").appendChild(newListItem);
            document.getElementById("current").appendChild(AmountItem);
            }
    }
    });
setInterval(function(){
    score = score + itemamount[0];
    score = score + itemamount[1] * 5;
    score = score + itemamount[2] * 15;
    score = score + itemamount[3] * 35;
    score = score + itemamount[4] * 75;
    score = score + itemamount[5] * 150;
    score = score + itemamount[6] * 225;
    score = score + itemamount[7] * 450;
    score = score + itemamount[8] * 1000;
    score = score + itemamount[9] * 2500;
    score = score + itemamount[10] * 5250;
    score = score + itemamount[11] * 10000;
    document.getElementById("point").innerHTML = score;
}, 1000);

const closeModalButtons = document.querySelectorAll('[data-close-button]')

closeModalButtons.forEach(button => {
    button.addEventListener('click', () => {
      const modal = button.closest('.modal')
      closeModal(modal);
      bgmusic.play();
    })
  })

  function closeModal(modal) {
    if (modal == null) return
    modal.classList.add('close')
    overlay.classList.add('close')
  }

  function togglesound(){
    if (bgmusic.duration == 0 || bgmusic.paused){
        bgmusic.play();
        document.getElementById("toggle").src = "https://i.imgur.com/jnfKSRc.png";
    } else{
        bgmusic.pause();
        document.getElementById("toggle").src = "https://i.imgur.com/acDi9YK.png";
    }
}