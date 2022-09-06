/*********************************************
 * OPL 12.6.3.0 Model
 * Author: conason
 * Creation Date: 2022-7-6 at ����4:19:54
 *********************************************/
 //M����������
 int M = 43;
 
 //N�ֲ���������
 int N = 7;
 
 //O�����̶�������
// int O = 39;
 
 //��MԼ��
 int MAX = 1000;
 
 
 //Distributors�����̷�Χ
 range Distributors = 1..M;
 
 //Zones�ֲ����ķ�Χ
 range Zones = 1..N;
 
 //����ֵ��ȡֵ��Χ
 range Zone = 2..8;
 
 //Orders�����ķ�Χ
// range Orders = 1..O;
 
 
 //��Լ��ҵ��USPE��˾���������
 float ProposedRates[Zone] = ...;
 //��Լ��ҵ��USPE��˾��������С����
 float ProposedMinimumCharge[Zone] = ...;
 //Blawnox�������������̵���������ֵ
 int BlawnoxZones[Distributors] = ...;
 
 //RA[i]    i�����̵�ֱ����������
 float RA[Distributors];
 execute {
  for(var i in Distributors){
    RA[i] = ProposedRates[BlawnoxZones[i]];
  }
 }
 //RAMIN[i] i������ֱ����ͷ���
 float RAMIN[Distributors];
 execute {
  for(var i in Distributors){
    RAMIN[i] = ProposedMinimumCharge[BlawnoxZones[i]];
  }
 }
 //�Ǻ�Լ�û���USPE��˾���������
 float PublishedRates[Zone] = ...;
 //�Ǻ�Լ�û���USPE��˾��������С����
 float PublishedMinimumCharge[Zone] = ...;
 //�����ֲ����ĵ�������̵�����ֵ
 int DistributorZones[Distributors][Zones] = ...;
 
 //RU[i][j] i������ʹ��j�ֲ����ĵ�ת�˵������ʣ�
 float RU[Distributors][Zones];
 execute{
 for(var i in Distributors){
    for(var j in Zones){
      RU[i][j] = PublishedRates[DistributorZones[i][j]];
    }
  } 
}

 //RUMIN[i][j] i������ʹ��j�ֲ�����ת����ͷ���
 float RUMIN[Distributors][Zones];
 execute{
 for(var i in Distributors){
    for(var j in Zones){
      RUMIN[i][j] = PublishedMinimumCharge[DistributorZones[i][j]];    
    }
  } 
}

 //W[i]     i�����̵��ܻ�������
 float WW[Distributors] = ...;
 
 //W[i][k]  i�����̵ĵ�k�ʶ�������
// float WO[Distributors][Orders] = ...;
 
 //NUM[i]   i�����̵��ܶ�������
 int NUM[Distributors] = ...;
 
 //FC    �����ֲ����ĵ��̶ܹ����ã�ÿ��$40000��
 float FC = 40000/52;
 
 //L[j]  SD�ܲ���j�ֲ����ĵľ���
 float L[Zones] = ...;
 
 //TR[i] SD�ܲ���j�ֲ����ĵĿ�������
 float TR[Zones] = ...;
 
 //HC[j] j�ֲ����ĵĵ��������������
 float HC[Zones] = ...;
 
// int rank[Zones] = [2,1,5,7,4,6,3];
 
// int A[Distributors][Zones] = ...;
// execute {
//  for(var i in Distributors){
//    for(var j in Zones){
//     for(var k in Zones){    
//      if(RU[i][j] == RU[i][k] && rank[j] >= rank[k] && j != k){
//        A[i][j] = 1;       
//      }else{
//        A[i][j] = 0;     
//      }
//    }
//  }
// }    
//}
 
// float R[Distributors];
// float RMIN[Distributors];
// int P[Distributors];
 
  //PA[i][k] i������ֱ���ĵ�K�ʶ����Ƿ�С�������ֵ��������ֵΪ0������Ϊ1 
 int PA[Distributors];
 execute {
  for(var i in Distributors){
      if(WW[i] == 0){
        PA[i] = 1;        
      }else if(WW[i]*RA[i] >= RAMIN[i]){
        PA[i] = 1;      
      }else{
        PA[i] = 0;      
      }
  }  
}
 

 //B[i] i�����̵��ܻ���С����ֵ��ֱ��B[i]ֵΪ 1������ת�� B[i]ֵΪ0
 int B[Distributors];
 execute{
 for(var i in Distributors){
    for(var j in Zones){
      if(RA[i]*WW[i] <= RAMIN[i]){
        B[i] = 1;      
      }else{
        B[i] = 0;      
      }    
    }
  } 
 }
 //��������������
// {string} DestinationZipCode = ...;
 
 //�ֲ�����
// {string} Location = ...;
 
 //P[i] i�����̵Ķ��������Ƿ������С������ֵ
//int P[Distributors];
// execute{
// for(var i in Distributors){
//    if(WW[i] > 15){
//        P[i] = 1;
//      }else{P[i] == 0;}
//  }
//  } 
// }
 
 
 
 
 //X[i] i�������Ƿ�ֱ�� 1��ֱ��  0��ת��
dvar boolean X[Distributors];
//Y[j]  j�ֲ������Ƿ����� 1������  0��������
dvar boolean Y[Zones];
//Z[i][j] i�������Ƿ���j�ֲ�����ת��  1����jת��  0������jת��
dvar boolean Z[Distributors][Zones];
//R[i]i�����̵�����˷�
dvar float R[Distributors];
//�����˹������Խ��������Է���
//dvar float+ sensitivity[Distributors];

//RMIN[i] �����˷ѷ��ʶ�Ӧ����С����
//dvar float RMIN[Distributors];

//dvar float A[Distributors][Zones];
//dexpr float R[i in Distributors] = min(j in Zones) (Y[j]*RU[i][j]+(1-Y[j])*MAX);
//dexpr float RMIN[i in Distributors] = min(j in Zones) (Y[j]*RUMIN[i][j]+(1-Y[j])*MAX);
//(1-X[i])*(R[i]*WW[i]*P[i] + (1-P[i])*RMIN[i])


minimize sum(i in Distributors) X[i]*(RA[i]*WW[i]*PA[i]+(1-PA[i])*RAMIN[i])+ 
sum(i in Distributors) (1-X[i])*R[i]*WW[i] + 
sum(j in Zones) (Y[j]*FC)+ 
sum(j in Zones) (Y[j]*L[j]*TR[j]/2) + 
sum(j in Zones) (sum(i in Distributors) HC[j]*Z[i][j]*NUM[i]);

//ֱ������
//ת�����ã�ת�����ÿ����Ƿ�С����ͷ���(������ֵ�ķ����̻��ȡֱ���Ĳ���)�����ǳɱ���ÿ�������̵Ķ������������DJ��˾����������������
//ƽ̯�̶ܹ�����
//����������ã�����һ����ҵ������ƽ̯�˷�
//DJ��˾��ת�˷����̵�ÿ������������ȡ�Ĵ����

subject to {
//i�������Ƿ�ת��
forall(i in Distributors) X[i] <= B[i];
//��j�ֲ����Ŀ�������������ѵķǺ�Լ�û��˷�ѡ��(��M��)
forall(i in Distributors)forall(j in Zones) R[i] <= (Y[j]*RU[i][j]+(1-Y[j])*MAX);
//ֱ����ת�� i������ֻ��ѡ��һ��
forall(i in Distributors) (X[i]+(sum(j in Zones) Z[i][j])) == 1;
//i�����̲�����û�����õķֲ�����
forall(i in Distributors,j in Zones) Z[i][j] <= Y[j];
//�����ֲ����ĳ���ת�������ܴ���20000
forall(j in Zones) (sum(i in Distributors) Z[i][j]*WW[i]) <= 20000;
//û�п����ķֲ����Ĳ�������ת����
forall(j in Zones) sum(i in Distributors) Z[i][j] >= Y[j];
//ѡ���ѿ����ķֲ�������ת�˷���͵Ķ�i�������˷���С��
forall(i in Distributors,j in Zones) (R[i] == RU[i][j]*Y[j]) >= Z[i][j] == 1;
//Y[j]�����ķֲ���������Ϊһ��
sum(j in Zones)Y[j]>=1;
}

