/* 목표
 * 1) 다른 node와 통신을 위한 server
 * 2) Web socket 사용
 */

import WebSocket, { WebSocketServer } from 'ws'

const sockets = []; // initconnection에서 받을 sockets 자료들을 담을 자료구조

const initP2PServer = (p2pPort) => {
    const server = new WebSocketServer({ port: p2pPort }); // 웹소켓 서버 만들어주는 클래스
    server.on('connection', (ws) => { // connection, close 등과 같은 on 내의 웹소켓 이벤트들은 이미 예약 돼있다. 우리는 갖다 쓰기만 하면 됨
        initConnection(ws);
    })
    console.log('Listening P2P Server Port : ', p2pPort);
}

const initConnection = (ws) => {
    sockets.push(ws);
}

export { initP2PServer }