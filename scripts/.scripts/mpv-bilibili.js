// ==UserScript==
// @name         Bilibili Auto MPV
// @namespace    http://tampermonkey.net/
// @version      2.1
// @description  自动用 MPV 播放并关闭原页面
// @author       You
// @match        https://www.bilibili.com/video/*
// @grant        window.close
// @grant        GM_registerMenuCommand
// @grant        GM_notification
// ==/UserScript==

(function() {
    'use strict';

    const bvid = window.location.href.match(/video\/(BV\w+)/)?.[1];
    if (!bvid) return;

    const autoHandle = () => {
        const videoUrl = `https://www.bilibili.com/video/${bvid}`;

        // 发送播放请求
        fetch(`http://localhost:15612/play?url=${encodeURIComponent(videoUrl)}`)
            .then(response => {
                if (!response.ok) throw new Error('服务端响应错误');

                // 开始尝试暂停视频
                let retryCount = 0;
                const tryPause = () => {
                    const video = document.querySelector('video');
                    if (video && !video.paused) {
                        video.pause();
                        // 兼容 B 站新版播放器
                        const pauseBtn = document.querySelector('.bpx-player-ctrl-play, .bilibili-player-video-btn-start');
                        if (pauseBtn) pauseBtn.click();
                        return true;
                    }
                    return retryCount++ < 20; // 最多重试 2 秒
                };

                // 每 100ms 尝试一次
                const interval = setInterval(() => {
                    if (!tryPause()) {
                        clearInterval(interval);
                        // 延迟关闭确保暂停生效
                        //setTimeout(() => {
                        //    window.history.length > 1 ? window.history.back() : window.close();
                        //}, 300);
                    }
                }, 100);
            })
            .catch(err => {
                GM_notification('MPV 启动失败: ' + err.message);
            });
    };

    // 自动执行
    autoHandle();

})();