/* 목표
 * 1) 블록체인 관련 함수
 * 2) 블록 구조 설계
 */

/* 블록체인 구조
 * - index: 블록체인의 높이
 * - data: 블록에 포함된 모든 데이터 (+트랜잭션 포함)
 * - timestamp: 블록이 생성 된 시간
 * - hash: 블록 내부 데이터로 생성한 sha256 값 => 블록의 유일성을 보장함
 * - previoushash: 이전 블록의 hash (이전 블록을 참조)
 */

import CryptoJS from 'crypto-js'

class CBlock {
    constructor(index, data, timestamp, hash, previousHash) {
        this.index = index;
        this.data = data;
        this.timestamp = timestamp;
        this.hash = hash;
        this.previousHash = previousHash;
    }
}

function getBlocks() {
    return blocks;
}

const calculateHash = (index, data, timestamp, previousHash) => {
    return CryptoJS.SHA256((index + data + timestamp + previousHash).toString()).toString(); // => sha256을 통해 암호화: 어떠한 형태/값이든 16진수(64자리)를 반환함. 그냥 sha256 모듈 설치해서 데이터들만 + 하고 메소드 적용하면 깔끔하게 된긴 함
}

// Create genesis block
const createGenesisBlock = () => {
    const genesisBlock = new CBlock(0, "whkwon's 1st block", new Date().getTime() / 1000, 0, 0);
    genesisBlock.hash = calculateHash(genesisBlock.index, genesisBlock.data, genesisBlock.timestamp, genesisBlock.previousHash);
    
    return genesisBlock;
}

// Create general block
const createBlock = (blockData) => {
    const previousBlock = blocks[blocks.length - 1];
    const nextIndex = previousBlock.index + 1
    const nextTimestamp = new Date().getTime() / 1000; // 1000: 초 단위로 변경
    const nextHash = calculateHash(nextIndex, blockData, nextTimestamp, previousBlock.hash);
    const newBlock = new CBlock(nextIndex, blockData, nextTimestamp, nextHash, previousBlock.hash);

    if (isValidNewBlock(newBlock, previousBlock)) {
        blocks.push(newBlock);
        return newBlock;
    }
    else {
        console.log('fail to create newblock');
        return null;
    }
}

/* Checking for data integrity(무결성)
 * 1) 블록의 인덱스가 이전 블록 인덱스보다 1크다
 * 2) 블록의 previousHash가 이전 블록의 hash이다
 * 3) 블록의 구조가 일치해야 한다
 */
const isValidBlockStructure = (newBlock) => {
    if (typeof newBlock.index === 'number'
     && typeof newBlock.data === 'string'
     && typeof newBlock.timestamp === 'number'
     && typeof newBlock.hash === 'string'
     && typeof newBlock.previousHash === 'string') return true;
     else return false;
}

const isValidNewBlock = (newBlock, previousBlock) => {
    if (newBlock.index !== previousBlock.index + 1) {
        console.log('invalid index')
        return false;
    }
    else if (newBlock.previousHash !== previousBlock.hash) {
        console.log('invalid previous hash');
        return false;
    }
    else if (isValidBlockStructure(newBlock) == false) {
        console.log('invalid block structure');
        return false;
    }

    return true;
}

const blocks = [createGenesisBlock()];

export { getBlocks, createBlock }