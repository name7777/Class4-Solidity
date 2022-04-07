/* 수학 연산
 * 지수 표현 : 10의 16승 = 10^16 = 10 ** 16 (솔리디티 표현방식)
 */

pragma solidity ^0.4.19;

contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; // =10^16 (지수표현)
}