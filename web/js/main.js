document.addEventListener("touchmove", function (event) {
        event.preventDefault();
    },
    {
        passive: false
    });

//DEV TOOLS
window.onload = function() {
    if (window.eruda) {
        eruda.init();
    }
}
