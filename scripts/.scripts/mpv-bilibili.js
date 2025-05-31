// ==UserScript==
// @name         MPV BiliBili
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Use mpv to play bilibili's video
// @author       SilverOfLight
// @match        https://www.bilibili.com/video/*
// @icon         https://i0.hdslb.com/bfs/static/jinkela/long/images/favicon.ico
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    const CONTROL_ID = 'my-custom-control-123';

    const bvid = window.location.href.match(/video\/(BV\w+)/)?.[1];
    if (!bvid) return;

    function playWithMpv() {
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

    function addCustomControl() {
        if (document.getElementById(CONTROL_ID)) return true;

        if (!document.body) return false;

        try {
            const button = document.createElement('button');
            button.id = CONTROL_ID;
            button.textContent = 'Watch with mpv';

            button.style.cssText = `
                position: fixed !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                bottom: 20px !important;
                right: 20px !important;
                z-index: 2147483647 !important;
                padding: 10px !important;
                background: #282a36e6 !important;
                color: white !important;
                border: none !important;
                border-radius: 4px !important;
                cursor: pointer !important;
                font-size: 16px !important;
                box-shadow: 0 2px 10px rgba(0,0,0,0.2) !important;
                line-height: 1 !important;
            `;

            button.addEventListener('click', function() {
                playWithMpv()
            });

            document.body.appendChild(button);
            return true;
        } catch (e) {
            console.error('油猴脚本错误:', e);
            return false;
        }
    }

    function init() {
        if (addCustomControl()) return;
        document.addEventListener('DOMContentLoaded', addCustomControl);
        window.addEventListener('load', addCustomControl);
        setTimeout(addCustomControl, 3000);
    }

    init();
})();
