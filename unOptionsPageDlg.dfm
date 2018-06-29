object OptionsPagesDlg: TOptionsPagesDlg
  Left = 565
  Top = 114
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 410
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000400000000000000000000000000044
    444444000000000000000000000000C4C4C4C4C4000000000000000000000004
    4C444C44400000000000000000000004CCC4C4C4C40000000000444040000000
    044C4444444400000004CC4C4C0000000004C444C4CCC48834CCC4CCC4000000
    00004C444C4C437F36CC4C4444000000000004C4CCCCC23836CCC40000000000
    0000004C4CCCCC23244C00000000000000000004C4CCCC64CC64000000000000
    000000004CCCCC44440000000000000000000000004040000000000000000000
    0000000000000000000000000000000000000DD0000000000000000000000000
    00000DD00000000000000000000000DDDDD00DD0DD00DD000DD0DD00DD000DD0
    00DD0DDD0DD0DD000DD0DD00DD00000000DD0DD00DD0DDDDDDD0DD00DD000000
    DDDD0DD00DD00DD0DD00DD00DD0000DDDDD00DD00DD00DD0DD00DD00DD000DDD
    D0000DDD0DD00DD0DD00DDD0DD000DD000000DD0DD000DD0DD00DD0DD0000DD0
    00DD0000000000DDD0000000000000DDDDD00000000000DDD000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 368
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 519
      Height = 358
      ActivePage = TabSheet1
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'ROI settings'
        object Bevel8: TBevel
          Left = 318
          Top = 19
          Width = 187
          Height = 100
          Shape = bsFrame
        end
        object Bevel3: TBevel
          Left = 4
          Top = 257
          Width = 163
          Height = 48
          Shape = bsFrame
        end
        object BevelROINr: TBevel
          Left = 4
          Top = 204
          Width = 163
          Height = 48
          Shape = bsFrame
        end
        object BevelFontColor: TBevel
          Left = 4
          Top = 112
          Width = 163
          Height = 87
          Shape = bsFrame
        end
        object BevelThickness: TBevel
          Left = 172
          Top = 19
          Width = 140
          Height = 170
          Shape = bsFrame
        end
        object BevelSetColor: TBevel
          Left = 4
          Top = 19
          Width = 163
          Height = 88
          Shape = bsFrame
        end
        object TitleSetROIColor: TLabel
          Left = 65
          Top = 68
          Width = 64
          Height = 32
          Alignment = taCenter
          Caption = 'Click to Set ROI Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object ShapeROIMonoColor: TShape
          Left = 20
          Top = 72
          Width = 25
          Height = 25
          Brush.Color = clRed
          OnMouseDown = ShapeROIMonoColorMouseDown
        end
        object TitleROIthickness: TLabel
          Left = 191
          Top = 25
          Width = 78
          Height = 13
          Caption = 'ROI thickness'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object TitleROIthickFactor: TLabel
          Left = 190
          Top = 78
          Width = 81
          Height = 13
          Hint = 'Adjust Thickness for Thicker ROI'
          Caption = 'Thicker Factor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ShapeROI: TShape
          Left = 274
          Top = 42
          Width = 25
          Height = 25
          Brush.Style = bsClear
        end
        object ShapeROIthicker: TShape
          Left = 274
          Top = 98
          Width = 25
          Height = 25
          Brush.Style = bsClear
          Pen.Width = 3
        end
        object ShapeFreeHand: TShape
          Left = 271
          Top = 151
          Width = 30
          Height = 25
          Brush.Color = clBtnFace
          Shape = stEllipse
        end
        object TitleFreeHand: TLabel
          Left = 184
          Top = 132
          Width = 116
          Height = 13
          Caption = 'Free Hand Thickness'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ShapeFontColor: TShape
          Left = 20
          Top = 164
          Width = 25
          Height = 25
          OnMouseDown = ShapeFontColorMouseDown
        end
        object TitleSetFontColor: TLabel
          Left = 65
          Top = 160
          Width = 68
          Height = 32
          Alignment = taCenter
          Caption = 'Click to Set Font Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label5: TLabel
          Left = 368
          Top = 23
          Width = 86
          Height = 16
          Caption = 'Measure Line'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object MesLineColor: TShape
          Left = 333
          Top = 86
          Width = 25
          Height = 25
          Brush.Color = 8454013
          OnMouseDown = MesLineColorMouseDown
        end
        object Label6: TLabel
          Left = 364
          Top = 90
          Width = 32
          Height = 16
          Alignment = taCenter
          Caption = 'Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object MesLineThickness: TShape
          Left = 441
          Top = 54
          Width = 51
          Height = 3
          Brush.Color = clLime
          Pen.Color = clLime
        end
        object Bevel9: TBevel
          Left = 172
          Top = 195
          Width = 140
          Height = 111
          Shape = bsFrame
        end
        object Bevel4: TBevel
          Left = 318
          Top = 123
          Width = 187
          Height = 181
          Shape = bsFrame
        end
        object Label11: TLabel
          Left = 349
          Top = 125
          Width = 125
          Height = 16
          Alignment = taCenter
          Caption = 'Scale Bars Settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label12: TLabel
          Left = 443
          Top = 61
          Width = 46
          Height = 13
          Caption = 'Thickness'
        end
        object LSTimeBarColor: TShape
          Left = 333
          Top = 178
          Width = 25
          Height = 14
          OnMouseDown = LSTimeBarColorMouseDown
        end
        object Label13: TLabel
          Left = 364
          Top = 177
          Width = 32
          Height = 16
          Alignment = taCenter
          Caption = 'Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object LSTimeBarThickness: TShape
          Left = 445
          Top = 157
          Width = 51
          Height = 5
        end
        object Label14: TLabel
          Left = 447
          Top = 168
          Width = 46
          Height = 13
          Caption = 'Thickness'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 337
          Top = 235
          Width = 73
          Height = 16
          Caption = 'Duration (s):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 422
          Top = 82
          Width = 34
          Height = 32
          Alignment = taCenter
          Caption = 'Caps Witdh'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label18: TLabel
          Left = 328
          Top = 199
          Width = 120
          Height = 16
          Alignment = taCenter
          Caption = 'Line Scan Time Bar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label19: TLabel
          Left = 337
          Top = 279
          Width = 75
          Height = 16
          Caption = 'Length ('#181'm):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 329
          Top = 257
          Width = 135
          Height = 16
          Alignment = taCenter
          Caption = '2D Windows Size Bar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object CheckBoxUseSameColForROI: TCheckBox
          Left = 15
          Top = 25
          Width = 136
          Height = 36
          Caption = 'Use Same Color for all ROI'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = CheckBoxUseSameColForROIClick
        end
        object trbThickerROI: TTrackBar
          Left = 184
          Top = 93
          Width = 80
          Height = 35
          Hint = 'Adjust Thickness of ROI'
          Max = 3
          Min = 1
          ParentShowHint = False
          PageSize = 1
          Position = 3
          ShowHint = True
          TabOrder = 1
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbThickerROIChange
        end
        object trbROIthickness: TTrackBar
          Left = 184
          Top = 37
          Width = 80
          Height = 35
          Hint = 'Adjust Thickness of ROI (pixels)'
          Min = 1
          ParentShowHint = False
          PageSize = 1
          Position = 1
          ShowHint = True
          TabOrder = 2
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbROIthicknessChange
        end
        object trbFreeHandThickness: TTrackBar
          Left = 184
          Top = 148
          Width = 80
          Height = 31
          Max = 6
          Min = 1
          PageSize = 1
          Position = 1
          TabOrder = 3
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbFreeHandThicknessChange
        end
        object CheckBoxUseSameFontCol: TCheckBox
          Left = 15
          Top = 122
          Width = 136
          Height = 31
          Caption = 'Use Same Font Color for ROI #'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          WordWrap = True
          OnClick = CheckBoxUseSameFontColClick
        end
        object CheckBoxEnableROINumbers: TCheckBox
          Left = 14
          Top = 210
          Width = 121
          Height = 35
          Caption = 'Enable ROI Numbering'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          WordWrap = True
          OnClick = CheckBoxEnableROINumbersClick
        end
        object EnableROIonAverWin: TCheckBox
          Left = 15
          Top = 264
          Width = 141
          Height = 35
          Caption = 'Enable ROI on Average Window'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          WordWrap = True
          OnClick = EnableROIonAverWinClick
        end
        object trbMesLineThickness: TTrackBar
          Left = 333
          Top = 40
          Width = 91
          Height = 29
          Max = 5
          Min = 1
          PageSize = 1
          Position = 1
          TabOrder = 7
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbMesLineThicknessChange
        end
        object ckbKeepOldROI: TCheckBox
          Left = 178
          Top = 210
          Width = 129
          Height = 80
          Caption = 'Keep Existing ROI in New File if Image    X and Y are Same'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 8
          WordWrap = True
          OnClick = ckbKeepOldROIClick
        end
        object trbLSTimeBarThickness: TTrackBar
          Left = 321
          Top = 143
          Width = 118
          Height = 29
          Max = 20
          Min = 1
          PageSize = 1
          Position = 1
          TabOrder = 9
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbLSTimeBarThicknessChange
        end
        object enLSTimeBarDuration: TEditNumerical
          Left = 416
          Top = 234
          Width = 36
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 3
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 10
          Text = '600'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 999.000000000000000000
          Delta = 0
          NumberKind = Floats
          WaitTime = 5000
          Precision = 1
          OnReturnPressed = enLSTimeBarDurationReturnPressed
        end
        object cbLSTimeBarVisible: TCheckBox
          Left = 337
          Top = 215
          Width = 65
          Height = 21
          Caption = 'Visible'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 11
          WordWrap = True
          OnClick = cbLSTimeBarVisibleClick
        end
        object enLineCapsWidth: TEditNumerical
          Left = 466
          Top = 89
          Width = 23
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 2
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 12
          Text = '51'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Max = 51.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 1
          OnReturnPressed = enLineCapsWidthReturnPressed
        end
        object enSizeBarLenghtINµm: TEditNumerical
          Left = 416
          Top = 278
          Width = 36
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 3
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 13
          Text = '10'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 999.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 1
          OnReturnPressed = enSizeBarLenghtINµmReturnPressed
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Mark Settings'
        object Bevel6: TBevel
          Left = 168
          Top = 34
          Width = 149
          Height = 113
        end
        object Bevel7: TBevel
          Left = 168
          Top = 152
          Width = 149
          Height = 109
        end
        object Bevel1: TBevel
          Left = 162
          Top = 28
          Width = 161
          Height = 239
          Shape = bsFrame
        end
        object BevelMark: TBevel
          Left = 4
          Top = 28
          Width = 151
          Height = 239
          Shape = bsFrame
        end
        object TitleSetMarkTable1Color: TLabel
          Left = 54
          Top = 180
          Width = 81
          Height = 32
          Alignment = taCenter
          Caption = 'Small Events Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object imgMarkBkg: TImage
          Left = 106
          Top = 90
          Width = 41
          Height = 41
        end
        object Label1: TLabel
          Left = 36
          Top = 108
          Width = 19
          Height = 13
          Caption = 'Size'
        end
        object TitMarkThick: TLabel
          Left = 21
          Top = 44
          Width = 46
          Height = 13
          Caption = 'Thickness'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object shSmEvent: TShape
          Left = 20
          Top = 182
          Width = 25
          Height = 25
          Brush.Color = clRed
          OnMouseDown = shSmEventMouseDown
        end
        object shBigEvent: TShape
          Left = 20
          Top = 226
          Width = 25
          Height = 25
          Brush.Color = clAqua
          OnMouseDown = shBigEventMouseDown
        end
        object TitTable2MarkColor: TLabel
          Left = 62
          Top = 222
          Width = 67
          Height = 32
          Alignment = taCenter
          Caption = 'Big Events Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Bevel2: TBevel
          Left = 330
          Top = 28
          Width = 173
          Height = 239
          Shape = bsFrame
        end
        object titMainWindow: TLabel
          Left = 193
          Top = 42
          Width = 99
          Height = 21
          Caption = 'Main Window'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object titAvWindow: TLabel
          Left = 180
          Top = 158
          Width = 125
          Height = 21
          Caption = 'Average Window'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 344
          Top = 50
          Width = 143
          Height = 21
          Caption = 'Mark File Comment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 372
          Top = 146
          Width = 65
          Height = 16
          Caption = 'Generate:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object trbMarkWith: TTrackBar
          Left = 12
          Top = 68
          Width = 80
          Height = 29
          Max = 5
          Min = 1
          PageSize = 1
          Position = 2
          TabOrder = 0
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbMarkWithChange
        end
        object trbMarkSize: TTrackBar
          Left = 12
          Top = 128
          Width = 80
          Height = 33
          Min = 3
          PageSize = 1
          Position = 5
          TabOrder = 1
          ThumbLength = 12
          TickMarks = tmBoth
          OnChange = trbMarkSizeChange
        end
        object DisplayBigMarks: TCheckBox
          Left = 179
          Top = 100
          Width = 115
          Height = 45
          Caption = 'Display Big Events Marks'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 2
          WordWrap = True
          OnClick = DisplayBigMarksClick
        end
        object DisplaySmallMarks: TCheckBox
          Left = 179
          Top = 66
          Width = 129
          Height = 37
          Caption = 'Display Small Events Marks'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 3
          WordWrap = True
          OnClick = DisplaySmallMarksClick
        end
        object ShowSmMarksOnAverWin: TCheckBox
          Left = 179
          Top = 184
          Width = 130
          Height = 29
          Caption = 'Show Small Events Marks'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          WordWrap = True
          OnClick = ShowSmMarksOnAverWinClick
        end
        object ShowBigMarksOnAverWin: TCheckBox
          Left = 179
          Top = 218
          Width = 130
          Height = 37
          Caption = 'Show Big Events Marks'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          WordWrap = True
          OnClick = ShowBigMarksOnAverWinClick
        end
        object GenGenSetComm: TCheckBox
          Left = 336
          Top = 168
          Width = 127
          Height = 41
          Caption = 'General Settings'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 6
          OnClick = GenGenSetCommClick
        end
        object GenAutoSearchComm: TCheckBox
          Left = 336
          Top = 206
          Width = 149
          Height = 47
          Caption = 'Auto Search Settings'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 7
          OnClick = GenAutoSearchCommClick
        end
        object PromptForComment: TCheckBox
          Left = 336
          Top = 88
          Width = 151
          Height = 39
          Caption = 'Prompt For Comment'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 8
          OnClick = PromptForCommentClick
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Image Controls'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        object Bevel17: TBevel
          Left = 152
          Top = 8
          Width = 344
          Height = 311
          Shape = bsFrame
        end
        object Bevel18: TBevel
          Left = 160
          Top = 32
          Width = 330
          Height = 71
        end
        object tlMajorPixSetTitle: TLabel
          Left = 223
          Top = 12
          Width = 203
          Height = 16
          Caption = 'Pixel Size and Frame Rate Override'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object tl100micr: TLabel
          Left = 295
          Top = 106
          Width = 76
          Height = 26
          Alignment = taCenter
          Caption = '100 '#181'm = pixels (bin 1x1)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lbMicronsPix: TLabel
          Left = 164
          Top = 67
          Width = 321
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = '1 pixel = 0.2234 microns'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object tlCheckToOverride: TLabel
          Left = 168
          Top = 109
          Width = 87
          Height = 26
          Caption = 'Check to Override File Values'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lbPixPer100Microns: TLabel
          Left = 164
          Top = 84
          Width = 321
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = '100 microns = 415 pixels'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbCurFileInfo: TLabel
          Left = 164
          Top = 34
          Width = 321
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Current File Info'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbBinning: TLabel
          Left = 164
          Top = 50
          Width = 321
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Binning'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Bevel20: TBevel
          Left = 5
          Top = 252
          Width = 137
          Height = 56
          Shape = bsFrame
        end
        object tlFrmSec: TLabel
          Left = 382
          Top = 206
          Width = 27
          Height = 13
          Alignment = taCenter
          Caption = 'Frm/s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label17: TLabel
          Left = 382
          Top = 228
          Width = 27
          Height = 13
          Alignment = taCenter
          Caption = 'Frm/s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object ChBoxNikonND2orTiff: TCheckBox
          Left = 168
          Top = 272
          Width = 113
          Height = 12
          Caption = 'Nikon ND2 or Tiff'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 0
          OnClick = ChBoxNikonND2orTiffClick
        end
        object ChBoxNoranPrairie: TCheckBox
          Left = 168
          Top = 184
          Width = 89
          Height = 12
          Caption = 'Noran (Prairie)'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 1
          OnClick = ChBoxNoranPrairieClick
        end
        object ChBoxTiffStack: TCheckBox
          Left = 168
          Top = 228
          Width = 125
          Height = 12
          Caption = 'Stack of Generic Tiffs'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 2
          OnClick = ChBoxTiffStackClick
        end
        object CbAndorTiffs: TCheckBox
          Left = 168
          Top = 140
          Width = 73
          Height = 12
          Caption = 'Andor Tiff'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 3
          OnClick = CbAndorTiffsClick
        end
        object ChBoxTIFF: TCheckBox
          Left = 168
          Top = 206
          Width = 127
          Height = 12
          Caption = 'Generic Grayscale Tiff'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 4
          OnClick = ChBoxTIFFClick
        end
        object cbAlignXofImagePlayback: TCheckBox
          Left = 11
          Top = 260
          Width = 124
          Height = 38
          Caption = 'Align Main Window and Playback Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          WordWrap = True
          OnClick = cbAlignXofImagePlaybackClick
        end
        object CbStreamPix: TCheckBox
          Left = 168
          Top = 250
          Width = 69
          Height = 12
          Caption = 'StreamPix'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 6
          OnClick = CbStreamPixClick
        end
        object NoranPrairieEdPix: TEditNumerical
          Left = 317
          Top = 181
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          Text = '203'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = NoranPrairieEdPixReturnPressed
        end
        object StreamPixEdPix: TEditNumerical
          Left = 317
          Top = 247
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 8
          Text = '458'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = StreamPixEdPixReturnPressed
        end
        object AndorEdPix: TEditNumerical
          Left = 317
          Top = 137
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 9
          Text = '375'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = AndorEdPixReturnPressed
        end
        object NikonEdPix: TEditNumerical
          Left = 317
          Top = 269
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 10
          Text = '375'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = NikonEdPixReturnPressed
        end
        object StackGenTiffEdPix: TEditNumerical
          Left = 317
          Top = 225
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 11
          Text = '415'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = StackGenTiffEdPixReturnPressed
        end
        object SingleGenTiffEdPix: TEditNumerical
          Left = 317
          Top = 203
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 12
          Text = '415'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = SingleGenTiffEdPixReturnPressed
        end
        object StackTiffFrmSec: TEditNumerical
          Left = 418
          Top = 225
          Width = 47
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 7
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 13
          Text = '30.000'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 0.001000000000000000
          Max = 1000.000000000000000000
          Delta = 0
          NumberKind = Floats
          WaitTime = 5000
          Precision = 3
          OnReturnPressed = StackTiffFrmSecReturnPressed
        end
        object SingleGenTiffFrmSec: TEditNumerical
          Left = 418
          Top = 203
          Width = 47
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 7
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 14
          Text = '30.000'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 0.001000000000000000
          Max = 1000.000000000000000000
          Delta = 0
          NumberKind = Floats
          WaitTime = 5000
          Precision = 3
          OnReturnPressed = SingleGenTiffFrmSecReturnPressed
        end
        object ChBoxBioRad: TCheckBox
          Left = 168
          Top = 162
          Width = 127
          Height = 12
          Caption = 'BioRad'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 15
          OnClick = ChBoxBioRadClick
        end
        object BioRadEdPix: TEditNumerical
          Left = 317
          Top = 159
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 16
          Text = '494'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = BioRadEdPixReturnPressed
        end
        object ChBoxZeiss: TCheckBox
          Left = 168
          Top = 294
          Width = 127
          Height = 12
          Caption = 'Zeiss CZI or LSM'
          Checked = True
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 17
          OnClick = ChBoxZeissClick
        end
        object ZeissLSMEdPix: TEditNumerical
          Left = 317
          Top = 291
          Width = 33
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 4
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 18
          Text = '415'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 1.000000000000000000
          Max = 5000.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = ZeissLSMEdPixReturnPressed
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Miscellaneous'
        object Bevel13: TBevel
          Left = 318
          Top = 6
          Width = 185
          Height = 279
          Shape = bsFrame
        end
        object Bevel10: TBevel
          Left = 172
          Top = 228
          Width = 139
          Height = 57
          Shape = bsFrame
        end
        object Bevel5: TBevel
          Left = 172
          Top = 6
          Width = 139
          Height = 141
          Shape = bsFrame
        end
        object shSymbSize: TShape
          Left = 260
          Top = 68
          Width = 7
          Height = 7
          Brush.Color = clRed
          Pen.Color = clRed
          Shape = stCircle
          OnMouseDown = shSymbSizeMouseDown
        end
        object lblSymbSize: TLabel
          Left = 272
          Top = 63
          Width = 23
          Height = 13
          Caption = '7 pix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 176
          Top = 14
          Width = 125
          Height = 32
          Alignment = taCenter
          Caption = 'Trace Symbol Size, Color - for Click Table'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lbMaxRatio: TLabel
          Left = 276
          Top = 252
          Width = 25
          Height = 19
          Alignment = taCenter
          AutoSize = False
          Caption = '3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 198
          Top = 234
          Width = 48
          Height = 13
          Caption = 'Max Ratio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Bevel11: TBevel
          Left = 6
          Top = 244
          Width = 159
          Height = 41
          Shape = bsFrame
        end
        object Label8: TLabel
          Left = 11
          Top = 249
          Width = 94
          Height = 28
          Alignment = taCenter
          Caption = 'Correct Time of Noran (SGI) Movies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Im1: TImage
          Tag = 1
          Left = 328
          Top = 60
          Width = 16
          Height = 16
          OnClick = Im1Click
        end
        object Im15: TImage
          Tag = 15
          Left = 328
          Top = 186
          Width = 16
          Height = 16
          OnClick = Im15Click
        end
        object Im3: TImage
          Tag = 3
          Left = 328
          Top = 78
          Width = 16
          Height = 16
          OnClick = Im3Click
        end
        object Im19: TImage
          Tag = 19
          Left = 328
          Top = 222
          Width = 16
          Height = 16
          OnClick = Im19Click
        end
        object Im5: TImage
          Tag = 5
          Left = 328
          Top = 96
          Width = 16
          Height = 16
          OnClick = Im5Click
        end
        object Im2: TImage
          Tag = 2
          Left = 346
          Top = 60
          Width = 16
          Height = 16
          OnClick = Im2Click
        end
        object Im7: TImage
          Tag = 7
          Left = 328
          Top = 114
          Width = 16
          Height = 16
          OnClick = Im7Click
        end
        object Im17: TImage
          Tag = 17
          Left = 328
          Top = 204
          Width = 16
          Height = 16
          OnClick = Im17Click
        end
        object Im9: TImage
          Tag = 9
          Left = 328
          Top = 132
          Width = 16
          Height = 16
          OnClick = Im9Click
        end
        object Im11: TImage
          Tag = 11
          Left = 328
          Top = 150
          Width = 16
          Height = 16
          OnClick = Im11Click
        end
        object Im13: TImage
          Tag = 13
          Left = 328
          Top = 168
          Width = 16
          Height = 16
          OnClick = Im13Click
        end
        object Im4: TImage
          Tag = 4
          Left = 346
          Top = 78
          Width = 16
          Height = 16
          OnClick = Im4Click
        end
        object Im6: TImage
          Tag = 6
          Left = 346
          Top = 96
          Width = 16
          Height = 16
          OnClick = Im6Click
        end
        object Im8: TImage
          Tag = 8
          Left = 346
          Top = 114
          Width = 16
          Height = 16
          OnClick = Im8Click
        end
        object Im10: TImage
          Tag = 10
          Left = 346
          Top = 132
          Width = 16
          Height = 16
          OnClick = Im10Click
        end
        object Im12: TImage
          Tag = 12
          Left = 346
          Top = 150
          Width = 16
          Height = 16
          OnClick = Im12Click
        end
        object Im14: TImage
          Tag = 14
          Left = 346
          Top = 168
          Width = 16
          Height = 16
          OnClick = Im14Click
        end
        object Im16: TImage
          Tag = 16
          Left = 346
          Top = 186
          Width = 16
          Height = 16
          OnClick = Im16Click
        end
        object Im18: TImage
          Tag = 18
          Left = 346
          Top = 204
          Width = 16
          Height = 16
          OnClick = Im18Click
        end
        object Im20: TImage
          Tag = 20
          Left = 346
          Top = 222
          Width = 16
          Height = 16
          OnClick = Im20Click
        end
        object ShapeSelFrame: TShape
          Left = 460
          Top = 209
          Width = 30
          Height = 30
          Brush.Color = clBlack
          Pen.Color = 8257405
          Pen.Width = 3
          OnMouseDown = ShapeSelFrameMouseDown
        end
        object Label9: TLabel
          Left = 380
          Top = 32
          Width = 71
          Height = 32
          Alignment = taCenter
          Caption = 'Button and Frame Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label10: TLabel
          Left = 378
          Top = 208
          Width = 76
          Height = 32
          Alignment = taCenter
          Caption = 'Selection Frame Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Bevel14: TBevel
          Left = 6
          Top = 125
          Width = 159
          Height = 41
          Shape = bsFrame
        end
        object Bevel15: TBevel
          Left = 172
          Top = 159
          Width = 139
          Height = 57
          Shape = bsFrame
        end
        object lbMaxGamma: TLabel
          Left = 276
          Top = 189
          Width = 25
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = '5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object tlGamma: TLabel
          Left = 206
          Top = 170
          Width = 23
          Height = 16
          Caption = 'Max'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Gam: TLabel
          Left = 240
          Top = 164
          Width = 9
          Height = 24
          Caption = 'g'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel19: TBevel
          Left = 6
          Top = 184
          Width = 159
          Height = 41
          Shape = bsFrame
        end
        object TtlTimeSerPlot: TLabel
          Left = 368
          Top = 16
          Width = 94
          Height = 16
          Caption = 'Time Series Plot'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Bevel21: TBevel
          Left = 6
          Top = 6
          Width = 159
          Height = 41
          Shape = bsFrame
        end
        object Bevel22: TBevel
          Left = 6
          Top = 65
          Width = 159
          Height = 53
          Shape = bsFrame
        end
        object Label21: TLabel
          Left = 392
          Top = 255
          Width = 61
          Height = 16
          Alignment = taCenter
          Caption = 'Grid Density:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
        end
        object trbSymbSize: TTrackBar
          Left = 178
          Top = 63
          Width = 69
          Height = 29
          Max = 6
          Min = 1
          Position = 3
          TabOrder = 0
          ThumbLength = 15
          OnChange = trbSymbSizeChange
        end
        object AlwaysUseSymb: TCheckBox
          Left = 178
          Top = 96
          Width = 125
          Height = 37
          Caption = 'Always Use Symbol for Table'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = AlwaysUseSymbClick
        end
        object MaxRatio: TTrackBar
          Left = 180
          Top = 252
          Width = 91
          Height = 23
          Max = 4
          Min = -1
          TabOrder = 2
          ThumbLength = 15
          OnChange = MaxRatioChange
        end
        object btCorrectTime: TButton
          Left = 114
          Top = 254
          Width = 45
          Height = 21
          Caption = 'Do it'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btCorrectTimeClick
        end
        object ListBoxColor: TListBox
          Left = 376
          Top = 166
          Width = 113
          Height = 37
          Style = lbOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Items.Strings = (
            'Button & ROI Color'
            'Button Number Color')
          ParentFont = False
          TabOrder = 4
        end
        object UndueColors: TToolBar
          Left = 409
          Top = 83
          Width = 47
          Height = 29
          Align = alNone
          ButtonHeight = 23
          Caption = 'UndueColors'
          DisabledImages = ImageListArrowsDisabl
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ImageListArrowsEnabled
          TabOrder = 5
          object ColUnDo: TToolButton
            Left = 0
            Top = 0
            Hint = 'Undo One Step'
            Enabled = False
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = ColUnDoClick
          end
          object ColReDo: TToolButton
            Left = 23
            Top = 0
            Hint = 'Redo One Step'
            Enabled = False
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = ColReDoClick
          end
        end
        object ResToOriginal: TButton
          Left = 376
          Top = 142
          Width = 113
          Height = 22
          Caption = 'Reset to Original'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = ResToOriginalClick
        end
        object ResetToInitial: TButton
          Left = 376
          Top = 118
          Width = 113
          Height = 22
          Caption = 'Undo All Changes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = ResetToInitialClick
        end
        object AllowFullPathOfLastFile: TCheckBox
          Left = 12
          Top = 129
          Width = 145
          Height = 33
          Caption = 'Show Full Path of Last File Open'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          WordWrap = True
          OnClick = AllowFullPathOfLastFileClick
        end
        object MaxGamma: TTrackBar
          Left = 182
          Top = 188
          Width = 91
          Height = 23
          Max = 3
          Min = 1
          PageSize = 1
          Position = 3
          TabOrder = 9
          ThumbLength = 15
          OnChange = MaxGammaChange
        end
        object cbUseMoviFilePath: TCheckBox
          Left = 12
          Top = 189
          Width = 145
          Height = 31
          Caption = 'Use Movie File Path                 for All Files'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 10
          WordWrap = True
          OnClick = cbUseMoviFilePathClick
        end
        object ChbCheckAllFilesExist: TCheckBox
          Left = 12
          Top = 10
          Width = 145
          Height = 33
          Caption = 'When Loading Check all Files (QED && Stack)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          WordWrap = True
          OnClick = ChbCheckAllFilesExistClick
        end
        object ChBLoadTimeStamps: TCheckBox
          Left = 12
          Top = 71
          Width = 145
          Height = 40
          Caption = 
            'Load ND2 && StreamPix Time Stamps when Open File && Not Load in ' +
            'RAM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          WordWrap = True
          OnClick = ChBLoadTimeStampsClick
        end
        object enGridDensity: TEditNumerical
          Left = 460
          Top = 255
          Width = 29
          Height = 18
          AutoSize = False
          Ctl3D = False
          MaxLength = 2
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 13
          Text = '4'
          HideText = False
          Alignment = taCenter
          ColorOnFocus = 12910591
          ColorOnNoFocus = 16770250
          FontOnFocus.Charset = DEFAULT_CHARSET
          FontOnFocus.Color = clWindowText
          FontOnFocus.Height = -11
          FontOnFocus.Name = 'Arial'
          FontOnFocus.Style = []
          FontOnNoFocus.Charset = DEFAULT_CHARSET
          FontOnNoFocus.Color = clWindowText
          FontOnNoFocus.Height = -11
          FontOnNoFocus.Name = 'Arial'
          FontOnNoFocus.Style = []
          Min = 2.000000000000000000
          Max = 32.000000000000000000
          Delta = 0
          WaitTime = 5000
          Precision = 0
          OnReturnPressed = enGridDensityReturnPressed
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 368
    Width = 529
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object OKBtn: TButton
      Left = 224
      Top = 3
      Width = 92
      Height = 31
      Caption = 'OK'
      TabOrder = 0
      OnClick = OKBtnClick
    end
  end
  object ColorDialogROI: TColorDialog
    Color = 65336
    CustomColors.Strings = (
      'ColorA=FFF1DF'
      'ColorB=FFFFFFFF'
      'ColorC=FFFFFFFF'
      'ColorD=FFFFFFFF'
      'ColorE=FFFFFFFF'
      'ColorF=FFFFFFFF'
      'ColorG=FFFFFFFF'
      'ColorH=FFFFFFFF'
      'ColorI=FFFFFFFF'
      'ColorJ=FFFFFFFF'
      'ColorK=FFFFFFFF'
      'ColorL=FFFFFFFF'
      'ColorM=FFFFFFFF'
      'ColorN=FFFFFFFF'
      'ColorO=FFFFFFFF'
      'ColorP=FFFFFFFF')
    Options = [cdFullOpen]
    Left = 472
    Top = 378
  end
  object PopupMenuYesNo: TPopupMenu
    Left = 418
    Top = 381
    object Yes: TMenuItem
      RadioItem = True
      OnClick = YesClick
    end
    object Cancel: TMenuItem
      Caption = 'Cancel'
    end
  end
  object ImageListArrowsEnabled: TImageList
    Left = 26
    Top = 357
    Bitmap = {
      494C010102000400CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFE7E7FF00000000
      C1F3CF8300000000C3FBDFC300000000C7FBDFE300000000CBFBDFD300000000
      DCF3CF3B00000000FF07E0FF00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object ImageListArrowsDisabl: TImageList
    Left = 142
    Top = 362
    Bitmap = {
      494C010102000400CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000080808000808080000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000008080800080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFE7E7FF00000000
      C1F3CF8300000000C3FBDFC300000000C7FBDFE300000000CBFBDFD300000000
      DCF3CF3B00000000FF07E0FF00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
