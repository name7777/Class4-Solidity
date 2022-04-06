/* 구조체와 배열 활용하기
 * 함수에 코드를 넣어 새로운 Zombie를 생성하여 zombies 배열에 추가하도록 한다
 * 새로운 좀비를 위한 name과 dna는 createZombie함수의 인자값이어야 한다
 * 코드를 한 줄로 간결하게 작성해 보자
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
        zombies.push(Zombie(_name, _dna));
    }
}