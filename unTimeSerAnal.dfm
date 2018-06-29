object frmTimeSerPlot: TfrmTimeSerPlot
  Left = 20
  Top = 30
  HorzScrollBar.ButtonSize = 10
  HorzScrollBar.Color = clSkyBlue
  HorzScrollBar.ParentColor = False
  HorzScrollBar.Size = 10
  HorzScrollBar.ThumbSize = 50
  HorzScrollBar.Visible = False
  VertScrollBar.ButtonSize = 10
  VertScrollBar.Color = clSkyBlue
  VertScrollBar.ParentColor = False
  VertScrollBar.Size = 10
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Time Series Plot'
  ClientHeight = 498
  ClientWidth = 705
  Color = clBtnFace
  Constraints.MaxWidth = 1200
  Constraints.MinWidth = 506
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
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
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 94
    Top = 383
    Width = 219
    Height = 55
    Shape = bsFrame
  end
  object lbImNum: TLabel
    Left = 582
    Top = 1
    Width = 65
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel6: TBevel
    Left = 656
    Top = 383
    Width = 45
    Height = 55
    Shape = bsFrame
  end
  object Bevel5: TBevel
    Left = 489
    Top = 383
    Width = 166
    Height = 55
    Shape = bsFrame
  end
  object Bevel4: TBevel
    Left = 425
    Top = 383
    Width = 64
    Height = 55
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 316
    Top = 383
    Width = 108
    Height = 55
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 3
    Top = 383
    Width = 89
    Height = 111
    Shape = bsFrame
  end
  object lbNrPoints: TLabel
    Left = 99
    Top = 416
    Width = 31
    Height = 17
    Hint = 'Consecutive Points to Find Minimum'
    AutoSize = False
    Caption = 'Points'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object titXaxis: TLabel
    Left = 3
    Top = 343
    Width = 32
    Height = 15
    Caption = 'X axis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object titFromTo: TLabel
    Left = 3
    Top = 364
    Width = 46
    Height = 15
    Caption = 'Process'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lbPeakThresh: TLabel
    Left = 569
    Top = 420
    Width = 22
    Height = 13
    Caption = '0.20'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object RatTitle: TLabel
    Left = 503
    Top = 405
    Width = 50
    Height = 15
    Caption = '(F-Fo)/Fo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object btGetPeeks: TSpeedButton
    Left = 493
    Top = 387
    Width = 25
    Height = 19
    Caption = 'Do'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btGetPeeksClick
  end
  object MeasTrace: TSpeedButton
    Left = 663
    Top = 388
    Width = 31
    Height = 23
    Hint = 'Vertical Data Measuring Cursor'
    AllowAllUp = True
    GroupIndex = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Glyph.Data = {
      96010000424D9601000000000000760000002800000019000000120000000100
      0400000000002001000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777977
      7777777777777000000077777777797777777777777770000000CCCCCC777977
      77777CCCCCCCC000000077777C7779777777C77777777000000077777C777977
      7777C777777770000000777777C77977777C7777777770000000777777C77977
      77C77777777770000000777777C7797777C77777777770000000777777C77977
      77C77777777770000000777777C779777C7777777777700000007777777C7977
      C777777777777000000077777777C9CC77777777777770000000777799999999
      9997777777777000000077777777797777777777777770000000777777777977
      7777777777777000000077777779999977777777777770000000777777999999
      9777777777777000000077779999999999977777777770000000}
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = MeasTraceClick
  end
  object sbSetRange: TSpeedButton
    Left = 172
    Top = 388
    Width = 72
    Height = 21
    Hint = 'Allows Selecting Range for Finding Minimum'
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Set Range'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = sbSetRangeClick
  end
  object FreezeMean: TSpeedButton
    Left = 256
    Top = 388
    Width = 51
    Height = 21
    Hint = 'Prevents Updating Minimum'
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Hold'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = FreezeMeanClick
  end
  object lbLSD: TLabel
    Left = 580
    Top = 444
    Width = 20
    Height = 14
    Caption = 'LSD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lbRSD: TLabel
    Left = 640
    Top = 444
    Width = 21
    Height = 14
    Caption = 'RSD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 345
    Top = 444
    Width = 64
    Height = 14
    Caption = 'Points to Get:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lbBaseline: TLabel
    Left = 96
    Top = 444
    Width = 72
    Height = 14
    Caption = 'Cont. Baseline:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 340
    Top = 473
    Width = 64
    Height = 14
    Caption = 'Points to Get:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 444
    Top = 473
    Width = 8
    Height = 14
    Caption = 'in'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 516
    Top = 473
    Width = 14
    Height = 14
    Caption = 'ms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lbFinalPoints: TLabel
    Left = 533
    Top = 444
    Width = 42
    Height = 14
    AutoSize = False
    Caption = '= 300'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 473
    Top = 443
    Width = 7
    Height = 16
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ubWithoutBaseline: TUniButton
    Left = 183
    Top = 442
    Width = 27
    Height = 19
    Hint = 'Continuous Baseline Off'
    Caption = 'Off'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = ubWithoutBaselineClick
    AllowDeSelect = False
    AllowUp = False
    ImNotSelScale = 1.000000000000000000
    ImSelScale = 1.000000000000000000
    ImHotScale = 1.000000000000000000
    CaptionHot = 'Off'
    CaptionSel = 'Off'
    ColorHot = 15717318
    ColorSel = 16777090
    ColorNotSel = clBtnFace
    FrameColor = clBtnShadow
    GroupIndex = 3
  end
  object ubGetBaseline: TUniButton
    Left = 212
    Top = 442
    Width = 24
    Height = 19
    Hint = 'Get Continuous Baseline'
    Caption = 'Get'
    ParentShowHint = False
    ShowHint = True
    OnClick = ubGetBaselineClick
    AllowDeSelect = False
    AllowUp = False
    ImNotSelScale = 1.000000000000000000
    ImSelScale = 1.000000000000000000
    ImHotScale = 1.000000000000000000
    CaptionHot = 'Get'
    CaptionSel = 'Get'
    ColorHot = 15717318
    ColorSel = 16777090
    ColorNotSel = clBtnFace
    FrameColor = clBtnShadow
    GroupIndex = 3
  end
  object unSubtractBaseline: TUniButton
    Left = 238
    Top = 442
    Width = 49
    Height = 19
    Hint = 'Subtract Continuous Baseline from Area Trace '
    Caption = 'Subtract'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = unSubtractBaselineClick
    AllowDeSelect = False
    AllowUp = False
    ImNotSelScale = 1.000000000000000000
    ImSelScale = 1.000000000000000000
    ImHotScale = 1.000000000000000000
    CaptionHot = 'Subtract'
    CaptionSel = 'Subtract'
    ColorHot = 15717318
    ColorSel = 16777090
    ColorNotSel = clBtnFace
    FrameColor = clBtnShadow
    GroupIndex = 3
  end
  object sbDelPeak: TSpeedButton
    Left = 598
    Top = 386
    Width = 52
    Height = 19
    Hint = 'Delete Peak Selected by Cursor'
    Caption = 'Del Peak'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = sbDelPeakClick
  end
  object sbUnDoDelPeak: TSpeedButton
    Left = 598
    Top = 413
    Width = 52
    Height = 19
    Hint = 'Restore the last Deleted Peak'
    Caption = 'UnDo'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = sbUnDoDelPeakClick
  end
  object unDivideByBaseline: TUniButton
    Left = 289
    Top = 442
    Width = 49
    Height = 19
    Hint = 'Divide Area Trace by Continuous Baseline'
    Caption = 'Divide'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = unDivideByBaselineClick
    AllowDeSelect = False
    AllowUp = False
    ImNotSelScale = 1.000000000000000000
    ImSelScale = 1.000000000000000000
    ImHotScale = 1.000000000000000000
    CaptionHot = 'Divide'
    CaptionSel = 'Divide'
    ColorHot = 15717318
    ColorSel = 16777090
    ColorNotSel = clBtnFace
    FrameColor = clBtnShadow
    GroupIndex = 3
  end
  object lbFc: TLabel
    Left = 385
    Top = 393
    Width = 34
    Height = 13
    Caption = 'Fc (Hz)'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnMouseDown = lbFcMouseDown
    OnMouseEnter = lbFcMouseEnter
    OnMouseLeave = lbFcMouseLeave
  end
  object ubCopyRangeFromXaxis: TUniButton
    Left = 644
    Top = 347
    Width = 9
    Height = 29
    Hint = 'Set Process range to  X axis range'
    ParentShowHint = False
    ShowHint = True
    OnClick = ubCopyRangeFromXaxisClick
    AllowDeSelect = False
    BevelColors = SystemColors
    ImageSel.Data = {
      46030000424D46030000000000003600000028000000090000001C0000000100
      18000000000010030000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
      FFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF0000000000
      00000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000000000000000000000
      000000FFFFFFFFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00
      0000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF0000000000
      00000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00
      0000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF0000000000
      00000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFF000000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00
      0000000000000000FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF00}
    ImNotSelScale = 1.000000000000000000
    ImSelScale = 1.000000000000000000
    ImHotScale = 1.000000000000000000
    ColorHot = clBtnFace
    ColorSel = clBtnFace
    ColorNotSel = clBtnFace
    ColorHotEnabled = False
    Selected = True
  end
  object lbThreshold: TLabel
    Left = 19
    Top = 414
    Width = 57
    Height = 14
    Caption = 'Threshold '#8805
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lbTimeSerAnalMode: TLabel
    Left = 10
    Top = 389
    Width = 75
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Intensity'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object pnAxes: TPanel
    Left = 86
    Top = 342
    Width = 438
    Height = 14
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 6
  end
  object ProgBarTimSerPlot: TProgressBar
    Left = 47
    Top = 1
    Width = 527
    Height = 15
    TabOrder = 0
    Visible = False
  end
  object cbTraceDivMin: TCheckBox
    Left = 98
    Top = 390
    Width = 69
    Height = 17
    Hint = 
      'Allows Normalization of Traces by Minimum found in Consecutive P' +
      'oints  or Continuous Baseline'
    Caption = 'Normalize'
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = cbTraceDivMinClick
  end
  object CheckBoxCursor: TCheckBox
    Left = 430
    Top = 417
    Width = 47
    Height = 15
    Hint = 'Horizontal Ruler (only in F/Fo plots)'
    Caption = 'Ruler'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = CheckBoxCursorClick
  end
  object CheckBoxSymbolOn: TCheckBox
    Left = 429
    Top = 390
    Width = 58
    Height = 16
    Hint = 'Allowes Symbol Use on Traces'
    Caption = 'Symbol'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = CheckBoxSymbolOnClick
  end
  object cbSmTraceFltSize: TComboBox
    Left = 318
    Top = 413
    Width = 62
    Height = 22
    Hint = 'Set Filter Size'
    Style = csOwnerDrawFixed
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnChange = cbSmTraceFltSizeChange
    Items.Strings = (
      'None'
      '3'
      '5'
      '7'
      '9'
      '11')
  end
  object panButtons: TPanel
    Left = 653
    Top = 23
    Width = 49
    Height = 359
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object TitleWindow: TLabel
      Left = 3
      Top = 322
      Width = 40
      Height = 15
      Caption = 'X zoom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ToolBarButContr: TToolBar
      Left = 0
      Top = 234
      Width = 48
      Height = 27
      Align = alNone
      ButtonHeight = 23
      Caption = 'ToolBarButContr'
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      HotImages = ImListToolBut
      Images = ImListToolBut
      TabOrder = 1
      object InclusiveExclusive: TToolButton
        Left = 0
        Top = 0
        Hint = 'Exclusive Mode'
        Caption = 'InclusiveExclusive'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = InclusiveExclusiveClick
      end
      object ShowAllTraces: TToolButton
        Left = 23
        Top = 0
        Hint = 'Show All Traces'
        Caption = 'ShowAllTraces'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = ShowAllTracesClick
      end
    end
    object StartStop: TToolBar
      Left = 0
      Top = 263
      Width = 46
      Height = 26
      Align = alNone
      ButtonHeight = 23
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      Images = ImListToolBut
      TabOrder = 2
      object StartAnal: TToolButton
        Left = 0
        Top = 0
        Hint = 'Start Analysis'
        Caption = 'StartAnal'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = StartAnalClick
      end
      object StopAnalButton: TToolButton
        Left = 23
        Top = 0
        Caption = 'StopAnalButton'
        ImageIndex = 3
        OnClick = StopAnalButtonClick
      end
    end
    object ColBut: TToolBar
      Left = 0
      Top = 0
      Width = 49
      Height = 233
      Align = alNone
      ButtonHeight = 23
      Caption = 'ColBut'
      DisabledImages = ImageListDisabledButt
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      HotImages = ImageListColOnButt
      Images = ImageListButOff
      TabOrder = 0
      Wrapable = False
      object ToolButton1: TToolButton
        Tag = 1
        Left = 0
        Top = 0
        Caption = 'ToolButton1'
        ImageIndex = 0
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton2: TToolButton
        Tag = 2
        Left = 23
        Top = 0
        Caption = 'ToolButton2'
        ImageIndex = 1
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton3: TToolButton
        Tag = 3
        Left = 0
        Top = 23
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton4: TToolButton
        Tag = 4
        Left = 23
        Top = 23
        Caption = 'ToolButton4'
        ImageIndex = 3
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton5: TToolButton
        Tag = 5
        Left = 0
        Top = 46
        Caption = 'ToolButton5'
        ImageIndex = 4
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton6: TToolButton
        Tag = 6
        Left = 23
        Top = 46
        Caption = 'ToolButton6'
        ImageIndex = 5
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton7: TToolButton
        Tag = 7
        Left = 0
        Top = 69
        Caption = 'ToolButton7'
        ImageIndex = 6
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton8: TToolButton
        Tag = 8
        Left = 23
        Top = 69
        Caption = 'ToolButton8'
        ImageIndex = 7
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton9: TToolButton
        Tag = 9
        Left = 0
        Top = 92
        Caption = 'ToolButton9'
        ImageIndex = 8
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton10: TToolButton
        Tag = 10
        Left = 23
        Top = 92
        Caption = 'ToolButton10'
        ImageIndex = 9
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton11: TToolButton
        Tag = 11
        Left = 0
        Top = 115
        Caption = 'ToolButton11'
        ImageIndex = 10
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton12: TToolButton
        Tag = 12
        Left = 23
        Top = 115
        Caption = 'ToolButton12'
        ImageIndex = 11
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton13: TToolButton
        Tag = 13
        Left = 0
        Top = 138
        Caption = 'ToolButton13'
        ImageIndex = 12
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton14: TToolButton
        Tag = 14
        Left = 23
        Top = 138
        Caption = 'ToolButton14'
        ImageIndex = 13
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton15: TToolButton
        Tag = 15
        Left = 0
        Top = 161
        Caption = 'ToolButton15'
        ImageIndex = 14
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton16: TToolButton
        Tag = 16
        Left = 23
        Top = 161
        Caption = 'ToolButton16'
        ImageIndex = 15
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton17: TToolButton
        Tag = 17
        Left = 0
        Top = 184
        Caption = 'ToolButton17'
        ImageIndex = 16
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton18: TToolButton
        Tag = 18
        Left = 23
        Top = 184
        Caption = 'ToolButton18'
        ImageIndex = 17
        Wrap = True
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton19: TToolButton
        Tag = 19
        Left = 0
        Top = 207
        Caption = 'ToolButton19'
        ImageIndex = 18
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
      object ToolButton20: TToolButton
        Tag = 20
        Left = 23
        Top = 207
        Caption = 'ToolButton20'
        ImageIndex = 19
        Style = tbsCheck
        OnClick = ToolButtonClick
        OnMouseDown = ToolButtonMouseDown
      end
    end
    object UnduRedu: TToolBar
      Left = 0
      Top = 297
      Width = 48
      Height = 26
      Align = alNone
      DisabledImages = ImListToolButDisabled
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      Images = ImListToolBut
      TabOrder = 3
      object UnDo: TToolButton
        Left = 0
        Top = 0
        Hint = 'UnDo Zoom by Mouse'
        Caption = 'UnDo'
        Enabled = False
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = UnDoClick
      end
      object ReDo: TToolButton
        Left = 23
        Top = 0
        Hint = 'ReDo Zoom by Mouse'
        Caption = 'ReDo'
        Enabled = False
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = ReDoClick
      end
    end
    object UpDownNrWin: TUpDown
      Left = 19
      Top = 338
      Width = 25
      Height = 19
      Associate = edlNrWin
      Enabled = False
      Min = 1
      Max = 10
      Orientation = udHorizontal
      Position = 1
      TabOrder = 4
      OnClick = UpDownNrWinClick
    end
    object edlNrWin: TEdit
      Left = 2
      Top = 338
      Width = 17
      Height = 19
      Alignment = taCenter
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      Text = '1'
    end
  end
  object cbGetPeaks: TCheckBox
    Left = 529
    Top = 385
    Width = 69
    Height = 21
    Hint = 'Enable Peak Detection'
    Caption = 'Get Peaks'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = cbGetPeaksClick
  end
  object scrbPeakThresh: TScrollBar
    Left = 493
    Top = 421
    Width = 71
    Height = 11
    Hint = 'Relative Threshold'
    Max = 500
    Min = 1
    PageSize = 0
    ParentShowHint = False
    Position = 10
    ShowHint = True
    TabOrder = 8
    OnChange = scrbPeakThreshChange
  end
  object TraceSel: TComboBox
    Left = 660
    Top = 412
    Width = 37
    Height = 22
    Style = csOwnerDrawFixed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnChange = TraceSelChange
  end
  object ShowMins: TPanel
    Left = 256
    Top = 414
    Width = 51
    Height = 20
    Hint = 'Displays Minumums Used'
    Caption = 'Show Min'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -10
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnMouseDown = ShowMinsMouseDown
  end
  object dsAnalRange: TDSlider
    Left = 54
    Top = 364
    Width = 503
    Height = 15
    Enabled = False
    Constraints.MinHeight = 5
    Constraints.MinWidth = 94
    Color = clBtnFace
    ColorSlider = 10676789
    ColorThumb = clBtnFace
    ColorTrack = 15530965
    ColorContour = clBlue
    Flat = False
    Frame = True
    Contour = True
    ThumbSize = 10
    Kind = Horizontal
    Min = 0
    Max = 100
    PosFrom = 0
    PosTo = 100
    Delta = 10
    Depressible = True
    AllowTimer = True
    OnChange = dsAnalRangeChange
  end
  object dsXaxes: TDSlider
    Left = 54
    Top = 343
    Width = 503
    Height = 15
    OnMouseUp = dsXaxesMouseUp
    Enabled = False
    Constraints.MinHeight = 5
    Constraints.MinWidth = 94
    Color = clBtnFace
    ColorSlider = 16761220
    ColorThumb = clBtnFace
    ColorTrack = 16770250
    ColorContour = clBlue
    Flat = False
    Frame = True
    Contour = True
    ThumbSize = 10
    Kind = Horizontal
    Min = 0
    Max = 10
    PosFrom = 0
    PosTo = 10
    Delta = 5
    Depressible = True
    AllowTimer = True
    OnChange = dsXaxesChange
  end
  object dsYaxes: TDSlider
    Left = 16
    Top = 38
    Width = 15
    Height = 263
    OnMouseUp = dsYaxesMouseUp
    Enabled = False
    Constraints.MinHeight = 94
    Constraints.MinWidth = 5
    Color = clBtnFace
    ColorSlider = 16761220
    ColorThumb = clBtnFace
    ColorTrack = 16770250
    ColorContour = clBlue
    Flat = False
    Frame = True
    Contour = True
    ThumbSize = 10
    Kind = Vertical
    Min = 0
    Max = 255
    PosFrom = 0
    PosTo = 255
    Delta = 5
    Depressible = True
    AllowTimer = True
    OnChange = dsYaxesChange
  end
  object enYtop: TEditNumerical
    Left = 3
    Top = 12
    Width = 40
    Height = 18
    AutoSize = False
    Ctl3D = False
    Enabled = False
    MaxLength = 5
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 14
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = [fsBold]
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = [fsBold]
    Max = 100.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 1
    OnReturnPressed = enYtopReturnPressed
  end
  object enYbottom: TEditNumerical
    Left = 3
    Top = 304
    Width = 40
    Height = 18
    AutoSize = False
    Ctl3D = False
    Enabled = False
    MaxLength = 5
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 15
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = [fsBold]
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = [fsBold]
    Max = 100.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 1
    OnReturnPressed = enYbottomReturnPressed
  end
  object enAnalFromTo: TEditNumerical
    Left = 560
    Top = 362
    Width = 83
    Height = 18
    AutoSize = False
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 17
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 15530965
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = [fsBold]
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = [fsBold]
    Max = 100.000000000000000000
    Delta = 2
    Numbers = Two
    WaitTime = 5000
    Precision = 0
    OnReturnPressed = enAnalFromToReturnPressed
  end
  object enXaxes: TEditNumerical
    Tag = 5
    Left = 560
    Top = 341
    Width = 83
    Height = 18
    AutoSize = False
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 16
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = [fsBold]
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = [fsBold]
    Max = 100.000000000000000000
    Delta = 1
    Numbers = Two
    WaitTime = 5000
    Precision = 0
    OnReturnPressed = enXaxesReturnPressed
  end
  inline FrameTimSerPlot: TFrameTimSerPlot
    Left = 47
    Top = 19
    Width = 600
    Height = 321
    HorzScrollBar.Tracking = True
    VertScrollBar.Visible = False
    AutoScroll = True
    TabOrder = 18
    TabStop = True
    ExplicitLeft = 47
    ExplicitTop = 19
    ExplicitWidth = 600
    ExplicitHeight = 321
    inherited imgTimeSerPlot: TImage [0]
      Left = 0
      Width = 600
      Height = 300
      OnMouseDown = FrameTimSerPlotimgTimeSerPlotMouseDown
      OnMouseLeave = FrameTimSerPlotimgTimeSerPlotMouseLeave
      OnMouseMove = FrameTimSerPlotimgTimeSerPlotMouseMove
      OnMouseUp = FrameTimSerPlotimgTimeSerPlotMouseUp
      ExplicitLeft = 0
      ExplicitWidth = 600
      ExplicitHeight = 300
    end
    inherited lblCursorVal: TLabel [1]
      Visible = False
    end
  end
  object enBaseLinePoints: TEditNumerical
    Left = 412
    Top = 441
    Width = 54
    Height = 21
    MaxLength = 4
    ParentFont = False
    TabOrder = 19
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 3.000000000000000000
    Max = 1000.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 0
    OnReturnPressed = enBaseLinePointsReturnPressed
  end
  object enLSD: TEditNumerical
    Left = 604
    Top = 441
    Width = 30
    Height = 21
    MaxLength = 3
    ParentFont = False
    TabOrder = 20
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 0.500000000000000000
    Max = 3.000000000000000000
    Delta = 0
    NumberKind = Floats
    WaitTime = 5000
    Precision = 1
    OnReturnPressed = enLSDReturnPressed
  end
  object enRSD: TEditNumerical
    Left = 667
    Top = 441
    Width = 30
    Height = 21
    MaxLength = 3
    ParentFont = False
    TabOrder = 21
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 0.100000000000000000
    Max = 3.000000000000000000
    Delta = 0
    NumberKind = Floats
    WaitTime = 5000
    Precision = 1
    OnReturnPressed = enRSDReturnPressed
  end
  object SlavePlot: TToolBar
    Left = 578
    Top = 472
    Width = 121
    Height = 22
    Align = alNone
    AutoSize = True
    Caption = 'SlavePlot'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 22
    object sbSlavePlot: TSpeedButton
      Left = 0
      Top = 0
      Width = 61
      Height = 22
      AllowAllUp = True
      GroupIndex = 4
      Caption = '2nd Plot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbSlavePlotClick
    end
    object sbTraceToDisplay: TSpeedButton
      Left = 61
      Top = 0
      Width = 60
      Height = 22
      Hint = 'Subtract or Divide by Baseline'
      AllowAllUp = True
      GroupIndex = 5
      Caption = 'Sub/Div'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbTraceToDisplayClick
    end
  end
  object enRangeFromTo: TEditNumerical
    Left = 167
    Top = 413
    Width = 83
    Height = 21
    AutoSize = False
    Ctl3D = True
    Enabled = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 23
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = [fsBold]
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = [fsBold]
    Max = 100.000000000000000000
    Delta = 10
    Numbers = Two
    WaitTime = 5000
    Precision = 0
  end
  object enTraceMinPoints: TEditNumerical
    Left = 133
    Top = 413
    Width = 28
    Height = 21
    MaxLength = 4
    ParentFont = False
    TabOrder = 24
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 1.000000000000000000
    Max = 1000.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 0
    OnReturnPressed = enTraceMinPointsReturnPressed
  end
  object NrPasses: TComboBox
    Left = 485
    Top = 441
    Width = 42
    Height = 21
    Hint = 'Maximal Scanning Window Width'
    ItemIndex = 4
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
    Text = '5'
    OnChange = NrPassesChange
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '21'
      '22'
      '23'
      '24'
      '25')
  end
  object edEachPeakBasePt: TEditNumerical
    Left = 410
    Top = 470
    Width = 30
    Height = 21
    MaxLength = 3
    ParentFont = False
    TabOrder = 26
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 1.000000000000000000
    Max = 999.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 0
    OnReturnPressed = edEachPeakBasePtReturnPressed
  end
  object edEachPeakBaseRg: TEditNumerical
    Left = 456
    Top = 470
    Width = 54
    Height = 21
    MaxLength = 5
    ParentFont = False
    TabOrder = 27
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 3.000000000000000000
    Max = 65535.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 0
    OnReturnPressed = edEachPeakBaseRgReturnPressed
  end
  object cbGetEachPeakBase: TCheckBox
    Left = 113
    Top = 472
    Width = 221
    Height = 17
    Caption = 'Get Baseline for Each Peak and Subtract'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 28
    OnClick = cbGetEachPeakBaseClick
  end
  object cbSmTraceKind: TComboBox
    Left = 318
    Top = 387
    Width = 62
    Height = 22
    Hint = 'Set the Smoothing Kind'
    Style = csOwnerDrawFixed
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 29
    OnChange = cbSmTraceKindChange
    Items.Strings = (
      'Boxcar'
      'Gauss'
      'Gauss Fc'
      'Kalman')
  end
  object enFcGaussFlt: TEditNumerical
    Left = 380
    Top = 414
    Width = 41
    Height = 21
    MaxLength = 6
    ParentFont = False
    TabOrder = 30
    Text = '5.00'
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Min = 0.100000000000000000
    Max = 99.000000000000000000
    Delta = 0
    NumberKind = Floats
    WaitTime = 5000
    Precision = 2
    OnReturnPressed = enFcGaussFltReturnPressed
  end
  object enThreshForArea: TEditNumerical
    Left = 20
    Top = 436
    Width = 55
    Height = 21
    Hint = 'Pixels '#8805' Threshold are used for Area trace'
    MaxLength = 5
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 31
    Text = '500000'
    HideText = False
    Alignment = taCenter
    ColorOnFocus = 12910591
    ColorOnNoFocus = 16770250
    FontOnFocus.Charset = DEFAULT_CHARSET
    FontOnFocus.Color = clWindowText
    FontOnFocus.Height = -11
    FontOnFocus.Name = 'MS Sans Serif'
    FontOnFocus.Style = []
    FontOnNoFocus.Charset = DEFAULT_CHARSET
    FontOnNoFocus.Color = clWindowText
    FontOnNoFocus.Height = -11
    FontOnNoFocus.Name = 'MS Sans Serif'
    FontOnNoFocus.Style = []
    Max = 50000.000000000000000000
    Delta = 0
    WaitTime = 5000
    Precision = 0
  end
  object ImageListColOnButt: TImageList
    Left = 396
    Top = 98
  end
  object ImageListButOff: TImageList
    Left = 464
    Top = 78
  end
  object ImageListDisabledButt: TImageList
    Left = 538
    Top = 70
  end
  object ImListToolBut: TImageList
    ShareImages = True
    Left = 250
    Top = 230
    Bitmap = {
      494C010106000900840110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000000000000000000000000000008080800080808000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000000000000000000080808000808080000000FF000000FF00000000000000
      00000000FF00FF000000FF0000000000000000000000FF000000FF000000FFFF
      00000000000000000000FFFF0000FFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800000000000FF0000000000000000000000FF000000000000008080
      800000000000000000008080800000000000000000000000FF00000000000000
      00000000FF0000000000FF0000000000000000000000FF00000000000000FFFF
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800000000000FF0000000000000000000000FF000000000000008080
      800000000000000000008080800000000000000000000000FF00000000000000
      00000000FF0000000000FF0000000000000000000000FF00000000000000FFFF
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800000000000FF0000000000000000000000FF000000000000008080
      800000000000000000008080800000000000000000000000FF00000000000000
      00000000FF0000000000FF0000000000000000000000FF00000000000000FFFF
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000008080
      80000000000000000000FF00000000000000FF00000000000000000000008080
      800000000000808080000000000000000000000000000000FF00000000000000
      FF000000000000000000FF00000000000000FF0000000000000000000000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000008080
      80000000000000000000FF00000000000000FF00000000000000000000008080
      800000000000808080000000000000000000000000000000FF00000000000000
      FF000000000000000000FF00000000000000FF0000000000000000000000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000008080
      80000000000000000000FF00000000000000FF00000000000000000000008080
      800000000000808080000000000000000000000000000000FF00000000000000
      FF000000000000000000FF00000000000000FF0000000000000000000000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000000000000FF000000FF0000000000000000000000000000008080
      800080808000000000000000000000000000000000000000FF000000FF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000000000000FF000000FF0000000000000000000000000000008080
      800080808000000000000000000000000000000000000000FF000000FF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000000000000FF000000FF0000000000000000000000000000008080
      800080808000000000000000000000000000000000000000FF000000FF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000FF000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000FF000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000000000000000FFFF
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
      0000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C00000FFFF0000FF000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FFFF0000FF000000FFFF00C0C0C0000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FFFF0000FF000000FFFF00C0C0C0000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FF0000C0C0C000000000000000
      000000000000000000000000000000000000000000000000FF00FFFFFF00FFFF
      FF000000FF000000FF00FFFFFF000000FF000000FF00FFFFFF000000FF000000
      FF00FFFFFF000000FF000000FF00000000000000000000000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF000000FF000000
      FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF000000FF000000FF00000000000000000000000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000000000000000
      000000000000000000000000000000000000000000000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000000000000000
      000000000000000000000000000000000000000000000000FF00FFFFFF000000
      FF000000FF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF000000FF00FFFFFF00000000000000000000000000800000008000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000000000000000
      00008080800080808000000000000000000000000000FFFFFF000000FF000000
      FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF000000FF00FFFFFF00000000000000000000000000800000000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00FFFFFF00FFFF
      FF000000FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF000000FF000000
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000008000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      318C318C00000000B5ADB5AD00000000B5ADB5AD00000000B5ADB5AD00000000
      AD6BAD6B00000000AD6BAD6B00000000AD6BAD6B000000009CE79CE700000000
      9CE79CE7000000009CE79CE700000000BDEFBDEF00000000BDEFBDEF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFC3FFFFFFFFFFFFFF81FF00F
      FFFFFFFFE007E007FFFFFFFFC003C003FFFFFFFFC0018001FFE7E7FFC0038001
      C1F3CF83F00F8001C3FBDFC3E0038001C7FBDFE3C0038001CBFBDFD3C0018001
      DCF3CF3BF80F8001FF07E0FFE0078001FFFFFFFFC003C003FFFFFFFFC001E007
      FFFFFFFFC003F00FFFFFFFFFFC1FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImListToolButDisabled: TImageList
    ShareImages = True
    Left = 354
    Top = 256
    Bitmap = {
      494C010106000900840110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000000000000000000000000000008080800080808000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000000000000000000080808000808080000000FF000000FF00000000000000
      00000000FF00FF000000FF0000000000000000000000FF000000FF000000FFFF
      00000000000000000000FFFF0000FFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800000000000FF0000000000000000000000FF000000000000008080
      800000000000000000008080800000000000000000000000FF00000000000000
      00000000FF0000000000FF0000000000000000000000FF00000000000000FFFF
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800000000000FF0000000000000000000000FF000000000000008080
      800000000000000000008080800000000000000000000000FF00000000000000
      00000000FF0000000000FF0000000000000000000000FF00000000000000FFFF
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800000000000FF0000000000000000000000FF000000000000008080
      800000000000000000008080800000000000000000000000FF00000000000000
      00000000FF0000000000FF0000000000000000000000FF00000000000000FFFF
      00000000000000000000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000008080
      80000000000000000000FF00000000000000FF00000000000000000000008080
      800000000000808080000000000000000000000000000000FF00000000000000
      FF000000000000000000FF00000000000000FF0000000000000000000000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000008080
      80000000000000000000FF00000000000000FF00000000000000000000008080
      800000000000808080000000000000000000000000000000FF00000000000000
      FF000000000000000000FF00000000000000FF0000000000000000000000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000008080
      80000000000000000000FF00000000000000FF00000000000000000000008080
      800000000000808080000000000000000000000000000000FF00000000000000
      FF000000000000000000FF00000000000000FF0000000000000000000000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000000000000FF000000FF0000000000000000000000000000008080
      800080808000000000000000000000000000000000000000FF000000FF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000000000000FF000000FF0000000000000000000000000000008080
      800080808000000000000000000000000000000000000000FF000000FF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000000000000FF000000FF0000000000000000000000000000008080
      800080808000000000000000000000000000000000000000FF000000FF000000
      00000000000000000000FF000000FF000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000FF000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000FF000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000FF00000000000000000000000000000000000000FFFF
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
      0000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C00000FFFF0000FF000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FFFF0000FF000000FFFF00C0C0C0000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FFFF0000FF000000FFFF00C0C0C0000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FF0000C0C0C000000000000000
      000000000000000000000000000000000000000000000000FF00FFFFFF00FFFF
      FF000000FF000000FF00FFFFFF000000FF000000FF00FFFFFF000000FF000000
      FF00FFFFFF000000FF000000FF00000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF000000FF000000
      FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF000000FF000000FF00000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000000000000000
      000000000000000000000000000000000000000000000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000000000000000
      000000000000000000000000000000000000000000000000FF00FFFFFF000000
      FF000000FF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF000000FF00FFFFFF00000000000000000000000000808080008080
      8000000000008080800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000000000000000
      00008080800080808000000000000000000000000000FFFFFF000000FF000000
      FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000FF00FFFFFF000000
      FF00FFFFFF000000FF00FFFFFF00000000000000000000000000808080000000
      0000000000000000000080808000808080000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000008080800080808000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00FFFFFF00FFFF
      FF000000FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF000000FF000000
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000008000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      318C318C00000000B5ADB5AD00000000B5ADB5AD00000000B5ADB5AD00000000
      AD6BAD6B00000000AD6BAD6B00000000AD6BAD6B000000009CE79CE700000000
      9CE79CE7000000009CE79CE700000000BDEFBDEF00000000BDEFBDEF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFC3FFFFFFFFFFFFFF81FF00F
      FFFFFFFFE007E007FFFFFFFFC003C003FFFFFFFFC0018001FFE7E7FFC0038001
      C1F3CF83F00F8001C3FBDFC3E0038001C7FBDFE3C0038001CBFBDFD3C0018001
      DCF3CF3BF80F8001FF07E0FFE0078001FFFFFFFFC003C003FFFFFFFFC001E007
      FFFFFFFFC003F00FFFFFFFFFFC1FFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenuDeletePeak: TPopupMenu
    Left = 606
    Top = 520
    object DeleteRow: TMenuItem
      Caption = 'Delete Peak'
      OnClick = sbDelPeakClick
    end
    object GoToImage: TMenuItem
      Caption = 'Go To Image'
      OnClick = GoToImageClick
    end
    object Cancel: TMenuItem
      Caption = 'Cancel'
    end
  end
end
