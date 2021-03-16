var tag = document.createElement('script');
tag.src = "https://www.youtube.com/player_api?enablejsapi=1";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var ytplayer;

var initPlayer = function(element) {
    var player = element.querySelector('.video-iframe');
    var button = element.querySelector('.video-play');
    ytplayer = new YT.Player(player, {
        playerVars: {
            'autoplay': 0,
            'modestbranding': 0,
            'controls': 1,
            'mute':0,
            'rel': 0,
        },
        videoId: element.dataset.id,
        events: {
            'onReady': onMainPlayerReady,
            'onStateChange': onPlayerMainStateChange
        }
    });

    button.addEventListener('click', function() {
        switch (ytplayer.getPlayerState()) {
            case 1:
                ytplayer.stopVideo();
                break;
            default:
                ytplayer.playVideo();
                break;
        }
    })
}

window.onYouTubePlayerAPIReady = function() {
    var container = document.querySelectorAll('.video-container');
    for (var i = 0; i < container.length; i++) {
        initPlayer(container[i])
    }
}
function onMainPlayerReady(event) {
    //event.target.playVideo();
}
function onPlayerMainStateChange(event) {
    if(event.data === 0){
        ytplayer.stopVideo();
    }
}
function changeVideo(video_id){
    ytplayer.cueVideoById(video_id);
    ytplayer.playVideo();
};
