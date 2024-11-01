// var img = new Image();
// img.src = '../files/dan/dan_fold.jpg';

// img.onload = function() {
//     document.getElementById("bg0").parentElement.style.display = "block";
// };

var i = 0;

document.addEventListener("DOMContentLoaded", function() {
    document.body.style.display = "none";
});

window.addEventListener("load", function() {
    document.body.style.display = "block";
    document.body.style.transition = "opacity 2s ease-in";
    document.body.style.opacity = 1;
});

// window.addEventListener("scroll", function() {
//     var width = document.documentElement.clientWidth;
//     var now = window.pageYOffset || document.documentElement.scrollTop;
    
//     if (now <= (5 * width / 6)) {
//         document.getElementById("bg0").style.display = "block";
//     } else if (now >= (5 * width / 6)) {
//         document.getElementById("bg0").style.display = "none";
//     }
// });

// var hashTagActive = "";
// document.querySelectorAll(".scroll").forEach(function(element) {
//     element.addEventListener("click", function(event) {
//         if (hashTagActive != this.hash) {
//             event.preventDefault();
//             var dest = 0;
//             var targetOffset = document.querySelector(this.hash).offsetTop;
            
//             if (targetOffset > document.body.scrollHeight - window.innerHeight) {
//                 dest = document.body.scrollHeight - window.innerHeight;
//             } else {
//                 dest = targetOffset;
//             }

//             window.scrollTo({
//                 top: dest,
//                 behavior: 'smooth'
//             });

//             hashTagActive = this.hash;
//         }
//     });
// });
