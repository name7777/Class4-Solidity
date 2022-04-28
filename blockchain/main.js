/* 목표
 * 1) p2p 서버 초기화, 사용 (서버1)
 * 2) http 서버 초기화, 사용 (서버2)
 * 3) block.js 내 블록체인 함수 사용
 */

import { initHttpServer } from './server-http.js'
import { initP2PServer } from './server-p2p.js'

const httpPort = process.env.HTTP_PORT || 3001;
const p2pPort = process.env.P2P_PORT || 6001;

initHttpServer(httpPort);
initP2PServer(p2pPort);