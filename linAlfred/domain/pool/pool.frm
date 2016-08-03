VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Pool 
   BackColor       =   &H00C0FFFF&
   Caption         =   "Simulated Pool"
   ClientHeight    =   9390
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11010
   LinkTopic       =   "Form1"
   ScaleHeight     =   9390
   ScaleWidth      =   11010
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox List1 
      Height          =   1230
      Left            =   1320
      TabIndex        =   22
      Top             =   9480
      Width           =   3975
   End
   Begin VB.CommandButton ConnectB 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Connect"
      Height          =   375
      Left            =   9480
      MaskColor       =   &H0080C0FF&
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   9960
      Width           =   1695
   End
   Begin VB.Frame Frame1 
      Caption         =   "Host"
      Height          =   1335
      Left            =   5520
      TabIndex        =   14
      Top             =   9480
      Width           =   3735
      Begin VB.TextBox IP 
         Enabled         =   0   'False
         Height          =   375
         Left            =   720
         TabIndex        =   19
         Text            =   "0"
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox Host 
         Enabled         =   0   'False
         Height          =   375
         Left            =   720
         TabIndex        =   16
         Text            =   "0"
         Top             =   240
         Width           =   2895
      End
      Begin VB.TextBox Port 
         Enabled         =   0   'False
         Height          =   375
         Left            =   2880
         TabIndex        =   15
         Text            =   "0"
         Top             =   720
         Width           =   735
      End
      Begin VB.Label Label3 
         BackStyle       =   0  'Transparent
         Caption         =   "IP"
         Height          =   255
         Left            =   120
         TabIndex        =   20
         Top             =   840
         Width           =   375
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Name"
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   495
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Port"
         Height          =   255
         Left            =   2400
         TabIndex        =   17
         Top             =   840
         Width           =   495
      End
   End
   Begin VB.TextBox Date 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "m/d/yy h:nn AM/PM"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1033
         SubFormatType   =   3
      EndProperty
      Enabled         =   0   'False
      Height          =   375
      Left            =   12720
      TabIndex        =   13
      Top             =   120
      Width           =   1935
   End
   Begin MSWinsockLib.Winsock Socket 
      Index           =   0
      Left            =   480
      Top             =   2280
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      LocalPort       =   1007
   End
   Begin VB.Frame Cooler 
      BackColor       =   &H80000008&
      Height          =   1095
      Index           =   0
      Left            =   13320
      TabIndex        =   9
      Top             =   6360
      Width           =   1455
      Begin VB.Timer Cooler2T 
         Enabled         =   0   'False
         Interval        =   1500
         Left            =   960
         Top             =   120
      End
      Begin VB.TextBox Text2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000008&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000009&
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   11
         Text            =   "Cooler 2"
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton Cooler2B 
         BackColor       =   &H80000009&
         Caption         =   "On"
         Height          =   255
         Left            =   840
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   720
         Width           =   495
      End
      Begin VB.Shape Cooler2 
         FillColor       =   &H00008000&
         FillStyle       =   0  'Solid
         Height          =   375
         Left            =   240
         Shape           =   3  'Circle
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame Cooler 
      BackColor       =   &H80000007&
      Height          =   1095
      Index           =   2
      Left            =   480
      TabIndex        =   6
      Top             =   4320
      Width           =   1455
      Begin VB.Timer Cooler1T 
         Enabled         =   0   'False
         Interval        =   1500
         Left            =   960
         Top             =   120
      End
      Begin VB.CommandButton Cooler1B 
         BackColor       =   &H00FFFFFF&
         Caption         =   "On"
         Height          =   255
         Left            =   840
         MaskColor       =   &H0080C0FF&
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   720
         Width           =   495
      End
      Begin VB.TextBox Text2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000007&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000009&
         Height          =   285
         Index           =   2
         Left            =   120
         TabIndex        =   7
         Text            =   "Cooler 1"
         Top             =   720
         Width           =   735
      End
      Begin VB.Shape Cooler1 
         FillColor       =   &H00008000&
         FillStyle       =   0  'Solid
         Height          =   375
         Left            =   240
         Shape           =   3  'Circle
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame Heater 
      BackColor       =   &H80000007&
      ForeColor       =   &H8000000E&
      Height          =   1095
      Index           =   1
      Left            =   13320
      TabIndex        =   4
      Top             =   4200
      Width           =   1455
      Begin VB.CommandButton Heater2B 
         BackColor       =   &H80000009&
         Caption         =   "On"
         Height          =   255
         Left            =   840
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   720
         Width           =   495
      End
      Begin VB.Timer Heater2T 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   960
         Top             =   120
      End
      Begin VB.TextBox Text2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000012&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000009&
         Height          =   285
         Index           =   1
         Left            =   120
         TabIndex        =   5
         Text            =   "Heater 2"
         Top             =   720
         Width           =   735
      End
      Begin VB.Shape Heater2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H00008000&
         FillStyle       =   0  'Solid
         Height          =   375
         Left            =   240
         Shape           =   3  'Circle
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.TextBox Temperature 
      Alignment       =   2  'Center
      Height          =   375
      Left            =   7080
      TabIndex        =   0
      Text            =   "50"
      Top             =   360
      Width           =   735
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   1080
      Top             =   2520
   End
   Begin VB.Frame Heater 
      BackColor       =   &H80000007&
      Height          =   1095
      Index           =   0
      Left            =   480
      TabIndex        =   1
      Top             =   6480
      Width           =   1455
      Begin VB.Timer Heater1T 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   960
         Top             =   240
      End
      Begin VB.TextBox Text2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000007&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000009&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Text            =   "Heater 1"
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton Heater1B 
         BackColor       =   &H80000009&
         Caption         =   "On"
         Height          =   255
         Left            =   840
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   720
         Width           =   495
      End
      Begin VB.Shape Heater1 
         FillColor       =   &H00008000&
         FillStyle       =   0  'Solid
         Height          =   375
         Left            =   240
         Shape           =   3  'Circle
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      BorderWidth     =   10
      Index           =   0
      X1              =   7440
      X2              =   7440
      Y1              =   720
      Y2              =   2040
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00FF0000&
      BackStyle       =   1  'Opaque
      FillColor       =   &H00FF0000&
      FillStyle       =   0  'Solid
      Height          =   7335
      Left            =   1800
      Shape           =   4  'Rounded Rectangle
      Top             =   1680
      Width           =   11655
   End
End
Attribute VB_Name = "Pool"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim iSockets As Integer

Private Sub ConnectB_Click()
    If ConnectB.Caption = "Connect" Then
        List1.AddItem "Listening to port: " & Socket(0).LocalPort
        Socket(0).Listen
        ConnectB.Caption = "Disconnect"
    Else
        List1.AddItem "Stop listening at port: " & Socket(0).LocalPort
        Socket(0).Close
        ConnectB.Caption = "Connect"
    End If
End Sub

Private Sub Cooler1B_Click()
If Cooler1B.Caption = "On" Then
    Cooler1.FillColor = &HFF&
    Cooler1B.Caption = "Off"
    Cooler1T.Enabled = True
Else
    Cooler1.FillColor = &H8000&
    Cooler1B.Caption = "On"
    Cooler1T.Enabled = False
End If
End Sub

Private Sub Cooler1T_Timer()
    Temperature.Text = Temperature.Text - 1
End Sub

Private Sub Cooler2B_Click()
If Cooler2B.Caption = "On" Then
    Cooler2.FillColor = &HFF&
    Cooler2B.Caption = "Off"
    Cooler2T.Enabled = True
Else
    Cooler2.FillColor = &H8000&
    Cooler2B.Caption = "On"
    Cooler2T.Enabled = False
End If
End Sub

Private Sub Cooler2T_Timer()
    Temperature.Text = Temperature.Text - 1
End Sub

Private Sub Form_Load()
Host.Text = Socket(0).LocalHostName
IP.Text = Socket(0).LocalIP
Port.Text = Socket(0).LocalPort
End Sub

Private Sub Heater1B_Click()
    If Heater1B.Caption = "On" Then
    Heater1.FillColor = &HFF&
    Heater1B.Caption = "Off"
    Heater1T.Enabled = True
Else
    Heater1.FillColor = &H8000&
    Heater1B.Caption = "On"
    Heater1T.Enabled = False
End If
End Sub

Private Sub Heater1T_Timer()
    Temperature.Text = Temperature.Text + 1
End Sub

Private Sub Heater2B_Click()
If Heater2B.Caption = "On" Then
    Heater2.FillColor = &HFF&
    Heater2B.Caption = "Off"
    Heater2T.Enabled = True
Else
    Heater2.FillColor = &H8000&
    Heater2B.Caption = "On"
    Heater2T.Enabled = False
End If
End Sub

Private Sub Heater2T_Timer()
    Temperature.Text = Temperature.Text + 1
End Sub

Private Sub socket_Close(Index As Integer)
    sServerMsg = "Connection closed: " & Socket(Index).RemoteHostIP
    List1.AddItem (sServerMsg)
    Socket(Index).Close
    Unload Socket(Index)
    iSockets = iSockets - 1
End Sub

Private Sub Socket_ConnectionRequest(Index As Integer, ByVal requestID As Long)
   ' If Socket.RemoteHostIP = AlfredIP Or Socket.RemoteHost = AlfredHost Then
  If Index = 0 Then
    List1.AddItem ("Connection Request from" & Socket(Index).RemoteHostIP)
    sRequestID = requestID
    Load Socket(1)
    Socket(1).LocalPort = Port.Text
    Socket(1).Accept requestID
    iSockets = 1
  End If
   ' End If
End Sub

Private Sub Socket_DataArrival(Index As Integer, ByVal bytesTotal As Long)
Dim Instruction As String
    Socket(Index).GetData Instruction, vbString
    List1.AddItem Instruction
    If (Instruction = "[[switch,on,heater1]]" And Heater1B.Caption = "On") Or _
        (Instruction = "[[switch,off,heater1]]" And Heater1B.Caption = "Off") Then
        Heater1B_Click
    End If
    If (Instruction = "[[switch,on,heater2]]" And Heater2B.Caption = "On") Or _
        (Instruction = "[[switch,off,heater2]]" And Heater2B.Caption = "Off") Then
        Heater2B_Click
    End If
    If (Instruction = "[[switch,on,cooler1]]" And Cooler1B.Caption = "On") Or _
        (Instruction = "[[switch,off,cooler1]]" And Cooler1B.Caption = "Off") Then
        Cooler1B_Click
    End If
    If (Instruction = "[[switch,on,cooler2]]" And Cooler2B.Caption = "On") Or _
        (Instruction = "[[switch,off,cooler2]]" And Cooler2B.Caption = "Off") Then
        Cooler2B_Click
    End If
    If Instruction = "[[read,temperature]]" Then
    'nothing now
    End If
    
End Sub

Private Sub Timer1_Timer()
  '  seconds.Text = seconds.Text + 1
    Date.Text = Now()
'    If seconds.Text = 60 Then
'        minutes.Text = minutes.Text + 1
'        seconds.Text = 0
'    End If
'    If minutes.Text = 60 Then
'        hours.Text = hours.Text + 1
'        minutes.Text = 0
'    End If
'    If hours.Text = 24 Then
'        day.Text = day.Text + 1
'   End If
End Sub

