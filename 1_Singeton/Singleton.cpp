#include <iostream>
#include "Singleton.h"

using namespace std;

CSingleton* CSingleton::m_pInst = nullptr;

CSingleton::CSingleton()
{
    count = 0;
}

CSingleton::~CSingleton()
{

}

CSingleton* CSingleton::getInstatnce()
{
    if (!m_pInst)
    {
        m_pInst = new CSingleton();
    }
    return m_pInst;
}

void CSingleton::DestroyInst()
{
    if (!m_pInst)
    {
        return;
    }
    delete m_pInst;
    m_pInst = nullptr;
}

void CSingleton::HelloWorld()
{   
    count ++;
    cout << "HelloWorld!!! - count(" << count << ")" << endl;
}