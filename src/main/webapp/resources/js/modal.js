// obtain Modal
var modals = document.getElementsByClassName("modal");
// obtain class which can pop up the Modal
var btns = document.getElementsByClassName("btn");
// obtain class that can close the Modal
var spanes = document.getElementsByClassName("close");
var funcs = [];

// open and close the Modal
function Modal(num) {
    return function() {
        // pop up modal
        btns[num].onclick =  function() {
            modals[num].style.display = "block";
        };

        // close the modal
        spanes[num].onclick = function() {
            modals[num].style.display = "none";
        };
    };
}

// call the modal as many as we want and define it into funcs function
for(var i = 0; i < btns.length; i++) {
    funcs[i] = Modal(i);
}

// call the modal as many as we want
for(var j = 0; j < btns.length; j++) {
    funcs[j]();
}

// close the modal when we click outside of the Modal area
window.onclick = function(event) {
    if (event.target.className == "modal") {
        event.target.style.display = "none";
    }
};