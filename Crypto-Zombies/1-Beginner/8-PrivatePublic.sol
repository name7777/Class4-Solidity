/* Private / Public 함수
 * 솔리디티에서 함수는 기본적으로 public으로 선언된다
 * 즉, 누구나 (혹은 다른 어느 컨트랙트가) 자신의 컨트랙트의 함수를 호출하고 코드를 실행할 수 있다는 의미다
 * 확실히 이는 항상 바람직한 건 아닐 뿐더러, 자신의 컨트랙트를 공격에 취약하게 만들 수 있다
 * 그러니 기본적으로 함수를 private으로 선언하고, 공개할 함수만 public으로 선언하는 것이 좋다
 * private는 컨트랙트 내의 다른 함수들만이 이 함수를 호출 가능하다
 * 함수 인자명과 마찬가지로 private 함수명도 언더바(_)로 시작하는 것이 관례이다
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
}