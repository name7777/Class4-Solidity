/* 함수 선언
 * 솔리디티 함수 인자명은 언더스코어(_)로 시작해서 전역 변수와 구별하는 것이 관례
 */

pragma solidity ^0.4.19;

contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function createZombie(string _name, uint _dna) {
        
    }
}