/* 목표
 * 1) 웹에 명령어를 입력해서 내 node를 제어하는 server
 */

// const express = require('express') // common js에서 라이브러리를 다 불러오기 때문에 크기도 크고 속도가 느려서 요즘은 import를 쓰는 추세
import express from 'express' // 딱 필요한 express만 불러옴. 따라서 크기나 속도면에서 더 compact함
import bodyParser from 'body-parser'
import { getBlocks, createBlock } from './block.js'

// Initialized function
const initHttpServer = (myHttpPort) => {
    const app = express();
    app.use(bodyParser.json());

    app.get('/', (req, res) => {
        res.send('Hello World');
    });

    app.get('/blocks', (req ,res) => {
        res.send(getBlocks());
    });

    app.post('/addblocks', (req, res) => {
        createBlock(req.body.data);
        res.send(`Block's info for '${req.body.data}' is complete.`);
    });

    app.listen(myHttpPort, () => {
        console.log('Listening httpServer Port : ', myHttpPort);
    });
}

export { initHttpServer }