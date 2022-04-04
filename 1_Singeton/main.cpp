// ★ VSC에서는 실행 안됨(header를 못읽는 것 같음). 결과는 Visual Studio 참고할 것
#include "Singleton.h"

int main(int argc, char** argv)
{
   CSingleton *ps1, *ps2;

   ps1 = CSingleton::getInstatnce();
   ps2 = CSingleton::getInstatnce();

   ps1->HelloWorld();
   
   CSingleton::getInstatnce()->HelloWorld();
   ps2->HelloWorld();

   // ps1->DestroyInst();
   //or
   CSingleton::DestroyInst();

   return 0;
}