/*
 * 솔리디티 배열 종류
 1) 정적 배열: [n] n개의 원소를 담을 수 있는 고정 길이의 배열
 2) 동적 배열: [] 고정된 크기 ㅏ없으며 계속 크기가 커질 수 있음

 * public 배열
 * 솔리디티는 getter 메소드를 자동적으로 생성하여 public으로 배열을 선언할 수 있음
 * 즉, 다른 컨트랙트들이 이 배열을 읽을 수 있게 된다(쓰기는 불가능)
 * 이는 컨트랙트에 공개 데이터를 저장할 때 유용한 패턴이다
*/

pragma solidity ^0.4.19;

contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies; // Zombie 구조체의 public 배열을 생성하고 이름을 zombies로 한다
}