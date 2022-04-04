VERSION 5.00
Begin VB.Form frmMapa 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   ClientHeight    =   6615
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9495
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   441
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   633
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      Height          =   1455
      Left            =   4200
      ScaleHeight     =   1395
      ScaleWidth      =   2115
      TabIndex        =   6
      Top             =   1080
      Width           =   2175
      Begin VB.Label Label12 
         BackColor       =   &H0000FF00&
         Caption         =   "204"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   2
         Left            =   1080
         TabIndex        =   29
         Top             =   960
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label12 
         BackColor       =   &H0000FF00&
         Caption         =   "203"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   1
         Left            =   1080
         TabIndex        =   28
         Top             =   720
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label12 
         BackColor       =   &H0000FF00&
         Caption         =   "202"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   0
         Left            =   720
         TabIndex        =   27
         Top             =   720
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label11 
         BackColor       =   &H0000FF00&
         Caption         =   "174"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1440
         TabIndex        =   26
         Top             =   1080
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label10 
         BackColor       =   &H0000FF00&
         Caption         =   "95"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   1
         Left            =   840
         TabIndex        =   25
         Top             =   1080
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label Label10 
         BackColor       =   &H0000FF00&
         Caption         =   "93"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   0
         Left            =   600
         TabIndex        =   24
         Top             =   1080
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label Label9 
         BackColor       =   &H0000FF00&
         Caption         =   "128"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   0
         Left            =   600
         TabIndex        =   23
         Top             =   360
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label9 
         BackColor       =   &H0000FF00&
         Caption         =   "109"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   1
         Left            =   960
         TabIndex        =   22
         Top             =   360
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label8 
         BackColor       =   &H0000FF00&
         Caption         =   "116"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   21
         Top             =   480
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label8 
         BackColor       =   &H0000FF00&
         Caption         =   "115"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   20
         Top             =   720
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label7 
         BackColor       =   &H0000FF00&
         Caption         =   "183"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   2
         Left            =   960
         TabIndex        =   19
         Top             =   960
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label7 
         BackColor       =   &H0000FF00&
         Caption         =   "181"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   1
         Left            =   600
         TabIndex        =   18
         Top             =   960
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label7 
         BackColor       =   &H0000FF00&
         Caption         =   "182"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   17
         Top             =   960
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "145"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   9
         Left            =   1440
         TabIndex        =   16
         Top             =   720
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "144"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   8
         Left            =   1080
         TabIndex        =   15
         Top             =   720
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "82"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   7
         Left            =   1440
         TabIndex        =   14
         Top             =   480
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "143"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   6
         Left            =   1080
         TabIndex        =   13
         Top             =   480
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "48"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   5
         Left            =   1080
         TabIndex        =   12
         Top             =   240
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "81"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   4
         Left            =   840
         TabIndex        =   11
         Top             =   240
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "146"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   3
         Left            =   480
         TabIndex        =   10
         Top             =   0
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "142"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   2
         Left            =   480
         TabIndex        =   9
         Top             =   240
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "141"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   1
         Left            =   480
         TabIndex        =   8
         Top             =   480
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FF00&
         Caption         =   "140"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Index           =   0
         Left            =   480
         TabIndex        =   7
         Top             =   720
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Shape Shape1 
         BorderColor     =   &H000000FF&
         Height          =   255
         Left            =   1800
         Top             =   120
         Width           =   255
      End
   End
   Begin VB.ListBox ListNpcs 
      BackColor       =   &H00404040&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   3900
      Left            =   6555
      TabIndex        =   0
      Top             =   2520
      Width           =   2910
   End
   Begin VB.Image IMGMAP 
      Height          =   315
      Index           =   87
      Left            =   2640
      Top             =   2160
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   195
      Index           =   86
      Left            =   2640
      Top             =   2520
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   85
      Left            =   720
      Top             =   3360
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   84
      Left            =   480
      Top             =   4320
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   83
      Left            =   840
      Top             =   5400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   82
      Left            =   840
      Top             =   5160
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   81
      Left            =   840
      Top             =   4920
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   80
      Left            =   840
      Top             =   4560
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   79
      Left            =   840
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   78
      Left            =   840
      Top             =   4080
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   77
      Left            =   1080
      Top             =   5400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   76
      Left            =   1080
      Top             =   5160
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   75
      Left            =   1080
      Top             =   4920
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   74
      Left            =   1080
      Top             =   4560
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   73
      Left            =   1080
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   72
      Left            =   1080
      Top             =   4080
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   71
      Left            =   1080
      Top             =   3840
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   70
      Left            =   1080
      Top             =   3600
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   69
      Left            =   1080
      Top             =   3240
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   68
      Left            =   1080
      Top             =   3000
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   67
      Left            =   1080
      Top             =   2640
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   66
      Left            =   1080
      Top             =   2400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   405
      Index           =   65
      Left            =   2760
      Top             =   5880
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   405
      Index           =   64
      Left            =   3120
      Top             =   5880
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   405
      Index           =   63
      Left            =   3480
      Top             =   5880
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   62
      Left            =   4080
      Top             =   6120
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   61
      Left            =   3720
      Top             =   6120
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   60
      Left            =   4080
      Top             =   5880
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   59
      Left            =   3720
      Top             =   5880
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   58
      Left            =   3720
      Top             =   5520
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   57
      Left            =   3720
      Top             =   5040
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   56
      Left            =   3120
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   55
      Left            =   2640
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   54
      Left            =   2160
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   53
      Left            =   1680
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   52
      Left            =   4560
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   51
      Left            =   4080
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   50
      Left            =   3720
      Top             =   2760
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   49
      Left            =   3720
      Top             =   3480
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   48
      Left            =   5400
      Top             =   3840
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   46
      Left            =   5400
      Top             =   4080
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   45
      Left            =   5040
      Top             =   4080
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   44
      Left            =   5280
      Top             =   4320
      Width           =   495
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   43
      Left            =   4560
      Top             =   4320
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   42
      Left            =   3720
      Top             =   4680
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   41
      Left            =   3720
      Top             =   4320
      Width           =   375
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   40
      Left            =   3480
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   39
      Left            =   3480
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   38
      Left            =   3240
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   37
      Left            =   3240
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   405
      Index           =   36
      Left            =   3000
      Top             =   4560
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   35
      Left            =   3000
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   34
      Left            =   2700
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   33
      Left            =   2700
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   32
      Left            =   2700
      Top             =   4080
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   31
      Left            =   2430
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   30
      Left            =   2430
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   29
      Left            =   2160
      Top             =   5160
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   28
      Left            =   2160
      Top             =   4920
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   27
      Left            =   2160
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   26
      Left            =   2160
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   25
      Left            =   1920
      Top             =   5400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   24
      Left            =   1920
      Top             =   5160
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   23
      Left            =   1920
      Top             =   4920
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   22
      Left            =   1920
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   21
      Left            =   1920
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   20
      Left            =   1635
      Top             =   5640
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   330
      Index           =   19
      Left            =   1635
      Top             =   5400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   18
      Left            =   1635
      Top             =   5160
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   17
      Left            =   1635
      Top             =   4920
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   285
      Index           =   16
      Left            =   1635
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   330
      Index           =   15
      Left            =   1635
      Top             =   4320
      Width           =   255
   End
   Begin VB.Label Label4 
      BackColor       =   &H00808080&
      BackStyle       =   0  'Transparent
      Caption         =   "Cerrar"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   5880
      TabIndex        =   5
      Top             =   120
      Width           =   525
   End
   Begin VB.Shape ShpMAP 
      BorderColor     =   &H000000FF&
      Height          =   255
      Left            =   3240
      Top             =   2280
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   14
      Left            =   1320
      Top             =   5640
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   13
      Left            =   1320
      Top             =   5400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   12
      Left            =   1320
      Top             =   5160
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   11
      Left            =   1320
      Top             =   4920
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   10
      Left            =   1320
      Top             =   4680
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   9
      Left            =   1320
      Top             =   4320
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   8
      Left            =   1320
      Top             =   4080
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   7
      Left            =   1320
      Top             =   3840
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   6
      Left            =   1320
      Top             =   3600
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   5
      Left            =   1320
      Top             =   3240
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   4
      Left            =   1320
      Top             =   3000
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   3
      Left            =   1320
      Top             =   2640
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   2
      Left            =   1320
      Top             =   2400
      Width           =   255
   End
   Begin VB.Image IMGMAP 
      Height          =   300
      Index           =   1
      Left            =   1320
      Top             =   2160
      Width           =   255
   End
   Begin VB.Label Label1 
      BackColor       =   &H00808080&
      BackStyle       =   0  'Transparent
      Caption         =   "NPcs en en mapa seleccionado: Selecciona un NPC para ver"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H008080FF&
      Height          =   495
      Left            =   6555
      TabIndex        =   4
      Top             =   2040
      Width           =   2925
   End
   Begin VB.Label Label3 
      BackColor       =   &H00404040&
      Caption         =   $"frmMapa.frx":0000
      ForeColor       =   &H00E0E0E0&
      Height          =   1455
      Left            =   6600
      TabIndex        =   3
      Top             =   120
      Width           =   2775
   End
   Begin VB.Label Label2 
      BackColor       =   &H00808080&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre del mapa:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H008080FF&
      Height          =   255
      Left            =   6555
      TabIndex        =   2
      Top             =   1560
      Width           =   2925
   End
   Begin VB.Label LblMAP 
      BackColor       =   &H00404040&
      Caption         =   "Selecciona un mapa.."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   6555
      TabIndex        =   1
      Top             =   1800
      Width           =   2925
   End
   Begin VB.Line Line3 
      BorderColor     =   &H00FFFFFF&
      X1              =   632
      X2              =   632
      Y1              =   0
      Y2              =   440
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      X1              =   432
      X2              =   632
      Y1              =   0
      Y2              =   0
   End
   Begin VB.Shape Personaje 
      BackColor       =   &H000000FF&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00000000&
      Height          =   135
      Left            =   3600
      Shape           =   3  'Circle
      Top             =   1920
      Width           =   375
   End
End
Attribute VB_Name = "frmMapa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Public BotonMapa As Byte
Public MouseX As Long
Public MouseY As Long

Private Sub Form_Load()
Me.Picture = LoadPicture(DirGraficos & "MapaJuego.jpg")
End Sub
Private Sub Form_Click()

If BotonMapa = 2 Then Call TelepPorMapa(MouseX, MouseY)

End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Personaje.Left = IzquierdaMapa + (UserPos.X - 50) * 0.18
Personaje.Top = TopMapa + (UserPos.Y - 50) * 0.18

End Sub
Private Sub Form_KeyPress(KeyAscii As Integer)

Personaje.Left = IzquierdaMapa + ((UserPos.X - 50) * 0.18)
Personaje.Top = TopMapa + ((UserPos.Y - 50) * 0.18)

End Sub
Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

Personaje.Left = IzquierdaMapa + (UserPos.X - 50) * 0.18
Personaje.Top = TopMapa + (UserPos.Y - 50) * 0.18

End Sub

Private Sub Form_LostFocus()
Me.Visible = False
End Sub

Private Sub Form_GotFocus()
Personaje.Left = IzquierdaMapa + (UserPos.X - 50) * 0.18
Personaje.Top = TopMapa + (UserPos.Y - 50) * 0.18
End Sub


Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If bmoving = False And Button = vbLeftButton Then
      Dx3 = X
      dy = Y
      bmoving = True
   End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If bmoving And ((X <> Dx3) Or (Y <> dy)) Then
      Move Left + (X - Dx3), Top + (Y - dy)
   End If
End Sub
Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If Button = vbLeftButton Then
      bmoving = False
   End If
End Sub

Private Sub IMGMAP_Click(Index As Integer)
    ShpMAP.Visible = True
    ShpMAP.Top = IMGMAP(Index).Top
    ShpMAP.Left = IMGMAP(Index).Left
    ShpMAP.Width = IMGMAP(Index).Width
    ShpMAP.Height = IMGMAP(Index).Height

Dim i As Integer
'If IMGMAP(Index).Top = ShpMAP.Top Then Exit Sub 'evito que mande muchos packets el negro.

Select Case Index
Case 0
Call SendData("XB" & 61)
Case 1
Call SendData("XB" & 60)
Case 2
Call SendData("XB" & 59)
Case 3
Call SendData("XB" & 58)
Case 4
Call SendData("XB" & 55)
Case 5
Call SendData("XB" & 54)
Case 6
Call SendData("XB" & 53)
Case 7
Call SendData("XB" & 6)
Case 8
Call SendData("XB" & 5)
Case 9
Call SendData("XB" & 1)
Case 10
Call SendData("XB" & 2)
Case 11
Call SendData("XB" & 3)
Case 12
Call SendData("XB" & 4)
Case 13
Call SendData("XB" & 32)
Case 14
Call SendData("XB" & 31)
Case 15
Call SendData("XB" & 11)
Case 16
Call SendData("XB" & 14)
Case 17
Call SendData("XB" & 25)
Case 18
Call SendData("XB" & 22)
Case 19
Call SendData("XB" & 29)
Case 20
Call SendData("XB" & 30)
Case 21
Call SendData("XB" & 12)
Case 22
Call SendData("XB" & 18)
Case 23
Call SendData("XB" & 26)
Case 24
Call SendData("XB" & 23)
Case 25

For i = 0 To 9
Label6(i).Visible = False
Next i

For i = 0 To 2
Label7(i).Visible = False
Next i

For i = 0 To 1
Label8(i).Visible = False
Next i

For i = 0 To 1
Label9(i).Visible = True
Next i

For i = 0 To 1
Label10(i).Visible = False
Next i

Label11.Visible = False

For i = 0 To 2
Label12(i).Visible = False
Next i

Call SendData("XB" & 28)
Case 26
Call SendData("XB" & 13)
Case 27
Call SendData("XB" & 19)
Case 28
Call SendData("XB" & 27)
Case 29
Call SendData("XB" & 24)
Case 30
Call SendData("XB" & 15)
Case 31
Call SendData("XB" & 98)
Case 32
Call SendData("XB" & 21)
Case 33

For i = 0 To 9
Label6(i).Visible = False
Next i

For i = 0 To 2
Label7(i).Visible = False
Next i

For i = 0 To 1
Label8(i).Visible = False
Next i

For i = 0 To 1
Label9(i).Visible = False
Next i

For i = 0 To 1
Label10(i).Visible = True
Next i

Label11.Visible = False

For i = 0 To 2
Label12(i).Visible = False
Next i

Call SendData("XB" & 16)
Case 34
Call SendData("XB" & 20)
Case 35
Call SendData("XB" & 17)
Case 36
Call SendData("XB" & 101)
Case 37
Call SendData("XB" & 104)
Case 38
Call SendData("XB" & 102)
Case 39
Call SendData("XB" & 103)
Case 40
Call SendData("XB" & 105)
Case 41
Call SendData("XB" & 62)
Case 42
Call SendData("XB" & 63)
Case 43
Call SendData("XB" & 118)
Case 44
Call SendData("XB" & 119)
Case 45
Call SendData("XB" & 149)
Case 46
Call SendData("XB" & 148)
Case 47
Call SendData("XB" & 147)
Case 48

For i = 0 To 9
Label6(i).Visible = False
Next i

For i = 0 To 2
Label7(i).Visible = False
Next i

For i = 0 To 1
Label8(i).Visible = False
Next i

For i = 0 To 1
Label9(i).Visible = False
Next i

For i = 0 To 1
Label10(i).Visible = False
Next i

Label11.Visible = True

For i = 0 To 2
Label12(i).Visible = False
Next i

Call SendData("XB" & 150)
Case 49
Call SendData("XB" & 106)
Case 50
Call SendData("XB" & 124)
Case 51
Call SendData("XB" & 138)
Case 52

For i = 0 To 9
Label6(i).Visible = True
Next i

For i = 0 To 2
Label7(i).Visible = False
Next i

For i = 0 To 1
Label8(i).Visible = False
Next i

For i = 0 To 1
Label9(i).Visible = False
Next i

For i = 0 To 1
Label10(i).Visible = False
Next i

Label11.Visible = False

For i = 0 To 2
Label12(i).Visible = False
Next i

Call SendData("XB" & 139)

Case 53
Call SendData("XB" & 163)
Case 54
Call SendData("XB" & 161)
Case 55
Call SendData("XB" & 160)
Case 56
Call SendData("XB" & 159)
Case 57
Call SendData("XB" & 152)
Case 58
Call SendData("XB" & 155)
Case 59
Call SendData("XB" & 111)
Case 60
Call SendData("XB" & 112)
Case 61
Call SendData("XB" & 114)
Case 62
Call SendData("XB" & 113)
Case 63
Call SendData("XB" & 156)
Case 64
Call SendData("XB" & 100)
Case 65

For i = 0 To 9
Label6(i).Visible = False
Next i

For i = 0 To 2
Label7(i).Visible = True
Next i

For i = 0 To 1
Label8(i).Visible = False
Next i

For i = 0 To 1
Label9(i).Visible = False
Next i

For i = 0 To 1
Label10(i).Visible = False
Next i

Label11.Visible = False

For i = 0 To 2
Label12(i).Visible = False
Next i

Call SendData("XB" & 97)
Case 66
Call SendData("XB" & 66)
Case 67
Call SendData("XB" & 65)
Case 68
Call SendData("XB" & 69)
Case 69
Call SendData("XB" & 70)
Case 70
Call SendData("XB" & 71)
Case 71
Call SendData("XB" & 73)
Case 72
Call SendData("XB" & 74)
Case 73
Call SendData("XB" & 8)
Case 74
Call SendData("XB" & 39)
Case 75
Call SendData("XB" & 36)
Case 76
Call SendData("XB" & 35)
Case 77
Call SendData("XB" & 34)
Case 78
Call SendData("XB" & 75)
Case 79
Call SendData("XB" & 9)
Case 80
Call SendData("XB" & 38)
Case 81
Call SendData("XB" & 46)
Case 82
Call SendData("XB" & 80)
Case 83
Call SendData("XB" & 78)
Case 84
Call SendData("XB" & 10)
Case 85

For i = 0 To 9
Label6(i).Visible = False
Next i

For i = 0 To 2
Label7(i).Visible = False
Next i

For i = 0 To 1
Label8(i).Visible = True
Next i

For i = 0 To 1
Label9(i).Visible = False
Next i

For i = 0 To 1
Label10(i).Visible = False
Next i

Label11.Visible = False

For i = 0 To 2
Label12(i).Visible = False
Next i

Call SendData("XB" & 76)
Case 86
Call SendData("XB" & 200)
Case 87

For i = 0 To 9
Label6(i).Visible = False
Next i

For i = 0 To 2
Label7(i).Visible = False
Next i

For i = 0 To 1
Label8(i).Visible = False
Next i

For i = 0 To 1
Label9(i).Visible = False
Next i

For i = 0 To 1
Label10(i).Visible = False
Next i

Label11.Visible = False

For i = 0 To 2
Label12(i).Visible = True
Next i


Call SendData("XB" & 201)

End Select

End Sub



Private Sub Label4_Click()
Call Audio.PlayWave(0, SND_CLICK)
Unload Me
End Sub

Private Sub Label6_Click(Index As Integer)
    Shape1.Visible = True
    Shape1.Top = Label6(Index).Top
    Shape1.Left = Label6(Index).Left
    Shape1.Width = Label6(Index).Width
    Shape1.Height = Label6(Index).Height

Select Case Index

Case 0
Call SendData("XB" & 140)
Case 1
Call SendData("XB" & 141)
Case 2
Call SendData("XB" & 142)
Case 3
Call SendData("XB" & 146)
Case 4
Call SendData("XB" & 81)
Case 5
Call SendData("XB" & 48)
Case 6
Call SendData("XB" & 143)
Case 7
Call SendData("XB" & 82)
Case 8
Call SendData("XB" & 144)
Case 9
Call SendData("XB" & 145)
End Select
End Sub

Private Sub Label7_Click(Index As Integer)
    Shape1.Visible = True
    Shape1.Top = Label7(Index).Top
    Shape1.Left = Label7(Index).Left
    Shape1.Width = Label7(Index).Width
    Shape1.Height = Label7(Index).Height

Select Case Index
Case 0
Call SendData("XB" & 182)
Case 1
Call SendData("XB" & 181)
Case 2
Call SendData("XB" & 183)
End Select

End Sub

Private Sub Label8_Click(Index As Integer)
    Shape1.Visible = True
    Shape1.Top = Label8(Index).Top
    Shape1.Left = Label8(Index).Left
    Shape1.Width = Label8(Index).Width
    Shape1.Height = Label8(Index).Height

Select Case Index
Case 0
Call SendData("XB" & 115)
Case 1
Call SendData("XB" & 116)
End Select

End Sub

Private Sub Label9_Click(Index As Integer)
    Shape1.Visible = True
    Shape1.Top = Label9(Index).Top
    Shape1.Left = Label9(Index).Left
    Shape1.Width = Label9(Index).Width
    Shape1.Height = Label9(Index).Height

Select Case Index
Case 0
Call SendData("XB" & 128)
Case 1
Call SendData("XB" & 109)
End Select

End Sub

Private Sub Label10_Click(Index As Integer)
    Shape1.Visible = True
    Shape1.Top = Label10(Index).Top
    Shape1.Left = Label10(Index).Left
    Shape1.Width = Label10(Index).Width
    Shape1.Height = Label10(Index).Height

Select Case Index
Case 0
Call SendData("XB" & 93)
Case 1
Call SendData("XB" & 95)
End Select

End Sub

Private Sub Label11_Click()
    Shape1.Visible = True
    Shape1.Top = Label11.Top
    Shape1.Left = Label11.Left
    Shape1.Width = Label11.Width
    Shape1.Height = Label11.Height


Call SendData("XB" & 174)

End Sub

Private Sub Label12_Click(Index As Integer)
    Shape1.Visible = True
    Shape1.Top = Label12(Index).Top
    Shape1.Left = Label12(Index).Left
    Shape1.Width = Label12(Index).Width
    Shape1.Height = Label12(Index).Height

Select Case Index
Case 0
Call SendData("XB" & 202)
Case 1
Call SendData("XB" & 203)
Case 2
Call SendData("XB" & 204)
End Select
End Sub
