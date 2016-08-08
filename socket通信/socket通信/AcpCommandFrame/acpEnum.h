//
//  acpEnum.h
//  socket通信
//
//  Created by neuracle on 16/8/4.
//  Copyright © 2016年 neuracle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ModuleType{
    
    Device = 0x01,
    EEG = 0x02,
    Impedance = 0x03,
    Sound = 0x04,
    Light = 0x05,
    SpO2 = 0x06,
    MEMS_ACC = 0x07,
    MEMS_GYR = 0x08,
    MEMS_MAG = 0x09,
    Temperature = 0x0A,
    Humidity = 0x0B,
    EnviromentLight = 0x0C,
    Event = 0x0D
    
}ModuleType;


typedef enum _PackageType
{
    Command = 0x01,
    CommandResponse = 0x02,
    Alert = 0x03,
    Notification = 0x04,
    BroadCastCommand = 0x05
    
}PackageType;


typedef enum _CommandType
{
    Hello = 0x01,
    Reset = 0x02,
    SetModPara = 0x03,
    SetDevPara = 0x04,
    Start = 0x05,
    GetDevStatus = 0x06,
    GetModStatus = 0x07
}CommandType;


typedef enum _BroadCastCommandType
{
    TimeSync = 0x01,
    QueryDevice = 0x02,
    DeviceInfo = 0x03
}BroadCastCommandType;


typedef enum _AlertType
{
    AlertEvnet = 0x01,
    Data = 0x02,
    BatteryLevelWarn = 0x03
    
}AlertType;


typedef enum _NotificationType
{
    Pulse = 0x01
    
}NotificationType;


typedef enum _ResultType
{
    Success = 0x01,
    UnknownPackage = 0x02,
    UnknownCommandPara = 0x03,
    CommandFailed = 0x04
}ResultType;


typedef enum _DeviceStatus
{
    WireLessSingleQuality = 0x01,
    SyncCode = 0x02,
    BatteryLevel = 0x03
}DeviceStatus;


typedef enum _AnalysisResult
{
    None = 0,
    AnalysisSuccess,
    Nopackage,
    WrongPackageSize,
    MisMacthToken,
    ErrorToken,
    MisMacthCRC,
    WrongHeaderSize,
    Uncontinue,
    HeadUnavailable,
    Waiting,
}AnalysisResult;


typedef enum _SampleRate
{
    SAMPLERATE_10HZ = 10,
    SAMPLERATE_50HZ = 50,
    SAMPLERATE_100HZ = 10,
    SAMPLERATE_250HZ = 250,
    SAMPLERATE_500HZ = 500,
    SAMPLERATE_1000HZ = 1000,
    SAMPLERATE_2000HZ = 2000,
}SampleRate;


typedef enum _GYRO_Scale
{
    G_SCALE_245DPS = 0x01,
    G_SCALE_500DPS = 0x02,
    G_SCALE_2000DPS = 0x03,
}GYRO_Scale;


typedef enum _ACC_Scale
{
    A_SCALE_2G = 0x01,
    A_SCALE_4G = 0x02,
    A_SCALE_6G = 0x03,
    A_SCALE_8G = 0x04,
    A_SCALE_16G = 0x05
}ACC_Scale;


typedef enum _MAG_Scale
{
    M_SCALE_2GS = 0x01,
    M_SCALE_4GS = 0x02,
    M_SCALE_8GS = 0x03,
    M_SCALE_12GS = 0x04,
}MAG_Scale;


typedef enum _PowerState
{
    Power_On = 0x01,
    Power_Off = 0x02
}PowerState;


typedef enum _WorkMode
{
    WM_Error = 0,
    WM_Normal = 1,
    WM_Wave = 4,
    WM_Short = 5,
    WM_Leadoff = 6,
    WM_PowerDown = 7,
    WM_TimeStamp = 8,
    WM_RLD = 9,
    WM_RLDALL = 10,
    WM_IMPEDANCE_OFFLINE = 12,
    WM_IMPEDANCE_ONLINE = 13,
    WM_SRB1 = 14,
    WM_SIMULATION_SIN = 21,
    WM_SIMULATION_SQUARE = 22,
    WM_SIMULATION_TRIANGLE = 23,
    WM_SIMULATION_CONST = 24
}WorkMode;


typedef enum _EventDataFormat
{
    EventData = 0x01,
    character = 0x02
    
}EventDataFormat;


typedef enum _EventType
{
    TriggerIn = 0x01,
    EventLight = 0x02,
    EventSound = 0x03
}EventType;




