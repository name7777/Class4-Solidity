/* 함수 더 알아보기
 * return(반환값) vs returns(반환값 종류)
 * view : 솔리디티에서 상태를 변화시키지 않을 때 즉, 어떤 값을 변경하거나 무언가를 쓰지 않을 때 함수를 view 함수로 선언. 이는 함수가 데이터를 보기만 하고 변경하지 않는다는 뜻
 * pure : 반환값이 함수에 전달된 인자값에 따라서 달라질 때 함수를 pure로 선언

 * 문제
    1) _generateRandomDna라는 private 함수를 만드시게. 이 함수는 _str (string형)을 인자로 전달받고, uint을 반환해야 하네.
    2) 이 함수는 컨트랙트 변수를 보지만 변경하지는 않을 것이므로 view로 선언하게.
    3) 이 함수의 내용은 현재로서는 비어 있는 상태로 냅두시게. 나중에 채울 것이네.
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

    function _createZombie(string _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna(string _str) private view returns(uint) {

    }
}