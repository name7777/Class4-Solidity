/* 이벤트
 * 이벤트는 자신의 컨트랙트가 블록체인 상에서 App의 사용자 단에서 무언가 액션이 발생했을 때 의사소통하는 방법이다
 * 컨트랙트는 특정 이벤트가 일어나는지 "귀를 기울이고" 그 이벤트가 발생하면 행동을 취한다

 * 문제
    1) NewZombie라는 event를 선언한다. zombieId (uint형), name (string형), dna (uint형)을 인자로 전달받아야 한다.
    2) _createZombie 함수를 변경하여 새로운 좀비가 zombies 배열에 추가된 후에 NewZombie 이벤트를 실행하도록 한다.
    3) 이벤트를 위해 좀비의 id가 필요할 것이다. array.push()는 배열의 새로운 길이를 uint형으로 반환한다.
    4) 배열의 첫 원소가 0이라는 인덱스를 갖기 때문에, array.push() - 1은 막 추가된 좀비의 인덱스가 될 것이다.
    5) zombies.push() - 1의 결과값을 uint형인 id로 저장하고 이를 다음 줄에서 NewZombie 이벤트를 위해 활용한다.
 */

pragma solidity ^0.4.19;

contract ZombieFactory {

    // 여기서 이벤트 선언
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private {
        // zombies.push(Zombie(_name, _dna));
        
        //여기서 이벤트 실행
        uint id = zombies.push(Zombie(_name, _dna)) - 1; // push는 그냥 인덱스 추가하는 '메소드'아님? 저 결과값이 어떻게 상수가 될 수 있는거지
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns(uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}