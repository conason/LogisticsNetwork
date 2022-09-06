/*********************************************
 * OPL 12.6.3.0 Model
 * Author: conason
 * Creation Date: 2022-7-6 at 下午4:19:54
 *********************************************/
 //M分销商索引
 int M = 43;
 
 //N分拨中心索引
 int N = 7;
 
 //O分销商订单索引
// int O = 39;
 
 //大M约束
 int MAX = 1000;
 
 
 //Distributors分销商范围
 range Distributors = 1..M;
 
 //Zones分拨中心范围
 range Zones = 1..N;
 
 //区域值的取值范围
 range Zone = 2..8;
 
 //Orders订单的范围
// range Orders = 1..O;
 
 
 //合约企业的USPE公司的运输费率
 float ProposedRates[Zone] = ...;
 //合约企业的USPE公司的运输最小费用
 float ProposedMinimumCharge[Zone] = ...;
 //Blawnox发往各个分销商的运输区域值
 int BlawnoxZones[Distributors] = ...;
 
 //RA[i]    i分销商的直发单磅费率
 float RA[Distributors];
 execute {
  for(var i in Distributors){
    RA[i] = ProposedRates[BlawnoxZones[i]];
  }
 }
 //RAMIN[i] i分销商直发最低费用
 float RAMIN[Distributors];
 execute {
  for(var i in Distributors){
    RAMIN[i] = ProposedMinimumCharge[BlawnoxZones[i]];
  }
 }
 //非合约用户的USPE公司的运输费率
 float PublishedRates[Zone] = ...;
 //非合约用户的USPE公司的运输最小费用
 float PublishedMinimumCharge[Zone] = ...;
 //各个分拨中心到达分销商的区域值
 int DistributorZones[Distributors][Zones] = ...;
 
 //RU[i][j] i分销商使用j分拨中心的转运单磅费率）
 float RU[Distributors][Zones];
 execute{
 for(var i in Distributors){
    for(var j in Zones){
      RU[i][j] = PublishedRates[DistributorZones[i][j]];
    }
  } 
}

 //RUMIN[i][j] i分销商使用j分拨中心转运最低费用
 float RUMIN[Distributors][Zones];
 execute{
 for(var i in Distributors){
    for(var j in Zones){
      RUMIN[i][j] = PublishedMinimumCharge[DistributorZones[i][j]];    
    }
  } 
}

 //W[i]     i分销商的周货物总重
 float WW[Distributors] = ...;
 
 //W[i][k]  i分销商的第k笔订单重量
// float WO[Distributors][Orders] = ...;
 
 //NUM[i]   i分销商的周订单总数
 int NUM[Distributors] = ...;
 
 //FC    单个分拨中心的周固定费用（每年$40000）
 float FC = 40000/52;
 
 //L[j]  SD总部到j分拨中心的距离
 float L[Zones] = ...;
 
 //TR[i] SD总部到j分拨中心的卡车费率
 float TR[Zones] = ...;
 
 //HC[j] j分拨中心的单件包裹处理费用
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
 
  //PA[i][k] i分销商直发的第K笔订单是否小于最低阈值，低于阈值为0，否则为1 
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
 

 //B[i] i分销商的周货量小于阈值就直发B[i]值为 1，否则转发 B[i]值为0
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
 //分销商邮政编码
// {string} DestinationZipCode = ...;
 
 //分拨中心
// {string} Location = ...;
 
 //P[i] i分销商的订单重量是否低于最小费用阈值
//int P[Distributors];
// execute{
// for(var i in Distributors){
//    if(WW[i] > 15){
//        P[i] = 1;
//      }else{P[i] == 0;}
//  }
//  } 
// }
 
 
 
 
 //X[i] i分销商是否直发 1：直发  0：转发
dvar boolean X[Distributors];
//Y[j]  j分拨中心是否启用 1：启用  0：不启用
dvar boolean Y[Zones];
//Z[i][j] i分销商是否由j分拨中心转运  1：由j转发  0：不由j转发
dvar boolean Z[Distributors][Zones];
//R[i]i经销商的最佳运费
dvar float R[Distributors];
//增加人工变量以进行敏感性分析
//dvar float+ sensitivity[Distributors];

//RMIN[i] 最优运费费率对应的最小费用
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

//直发费用
//转发费用，转发不用考虑是否小于最低费用(低于阈值的分销商会采取直发的策略)，考虑成本对每个分销商的订单打包后再由DJ公司代发给各个分销商
//平摊周固定费用
//卡车运输费用，与另一家企业共享卡车平摊运费
//DJ公司对转运分销商的每个订单包裹收取的处理费

subject to {
//i经销商是否转运
forall(i in Distributors) X[i] <= B[i];
//在j分拨中心开启的情形下最佳的非合约用户运费选择(大M法)
forall(i in Distributors)forall(j in Zones) R[i] <= (Y[j]*RU[i][j]+(1-Y[j])*MAX);
//直发与转发 i分销商只能选择一条
forall(i in Distributors) (X[i]+(sum(j in Zones) Z[i][j])) == 1;
//i分销商不能走没有启用的分拨中心
forall(i in Distributors,j in Zones) Z[i][j] <= Y[j];
//单个分拨中心承载转运量不能大于20000
forall(j in Zones) (sum(i in Distributors) Z[i][j]*WW[i]) <= 20000;
//没有开启的分拨中心不会有运转策略
forall(j in Zones) sum(i in Distributors) Z[i][j] >= Y[j];
//选择已开启的分拨中心中转运费最低的对i经销商运费最小的
forall(i in Distributors,j in Zones) (R[i] == RU[i][j]*Y[j]) >= Z[i][j] == 1;
//Y[j]开启的分拨中心最少为一个
sum(j in Zones)Y[j]>=1;
}

