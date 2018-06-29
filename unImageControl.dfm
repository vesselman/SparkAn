object frmImageControl: TfrmImageControl
  Left = 325
  Top = 105
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Image Settings & Tools'
  ClientHeight = 553
  ClientWidth = 280
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
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
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object pnImContr: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 553
    Color = clMedGray
    Constraints.MinHeight = 527
    Constraints.MinWidth = 280
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object BevelXYsliders: TBevel
      Left = 3
      Top = 510
      Width = 274
      Height = 38
      Shape = bsFrame
    end
    object ColorBar: TImage
      Left = 4
      Top = 3
      Width = 52
      Height = 272
    end
    object PixValPlot: TImage
      Left = 108
      Top = 3
      Width = 128
      Height = 64
    end
    object lblGamma: TLabel
      Left = 77
      Top = 147
      Width = 9
      Height = 24
      Hint = 'Help -  Right Mouse Button'
      Caption = 'g'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lblGammaMouseDown
      OnMouseEnter = lblGammaMouseEnter
      OnMouseLeave = lblGammaMouseLeave
    end
    object lblMaxRatOrCa: TLabel
      Left = 60
      Top = 221
      Width = 43
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Alignment = taCenter
      AutoSize = False
      Caption = 'Max R.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lblMaxRatOrCaMouseDown
      OnMouseEnter = lblMaxRatOrCaMouseEnter
      OnMouseLeave = lblMaxRatOrCaMouseLeave
    end
    object LabContrast: TLabel
      Left = 65
      Top = 112
      Width = 32
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Slope'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = LabContrastMouseDown
      OnMouseEnter = LabContrastMouseEnter
      OnMouseLeave = LabContrastMouseLeave
    end
    object lblBkg: TLabel
      Left = 62
      Top = 241
      Width = 35
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Bkg: 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lblBkgMouseDown
      OnMouseEnter = lblBkgMouseEnter
      OnMouseLeave = lblBkgMouseLeave
    end
    object lblCutOff: TLabel
      Left = 64
      Top = 261
      Width = 34
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Cutoff'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lblCutOffMouseDown
      OnMouseEnter = lblCutOffMouseEnter
      OnMouseLeave = lblCutOffMouseLeave
    end
    object LabBrigthness: TLabel
      Left = 68
      Top = 132
      Width = 26
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Shift'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = LabBrigthnessMouseDown
      OnMouseEnter = LabBrigthnessMouseEnter
      OnMouseLeave = LabBrigthnessMouseLeave
    end
    object lblBoxXsize: TLabel
      Left = 172
      Top = 513
      Width = 48
      Height = 17
      AutoSize = False
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlBottom
    end
    object lblBoxYsize: TLabel
      Left = 172
      Top = 528
      Width = 48
      Height = 16
      AutoSize = False
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object TitleXofROI: TLabel
      Left = 8
      Top = 515
      Width = 10
      Height = 16
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TitleYofROI: TLabel
      Left = 8
      Top = 528
      Width = 11
      Height = 16
      Caption = 'Y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblXmicrons: TLabel
      Left = 223
      Top = 513
      Width = 51
      Height = 17
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblYmicrons: TLabel
      Left = 223
      Top = 528
      Width = 51
      Height = 17
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object bnTransp: TSpeedButton
      Left = 61
      Top = 279
      Width = 41
      Height = 19
      Hint = 'Enable Average Image Transparency'
      AllowAllUp = True
      GroupIndex = 5
      Caption = 'Transp'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = bnTranspClick
    end
    object NegColTabl: TSpeedButton
      Left = 66
      Top = 192
      Width = 31
      Height = 23
      Hint = 'Make Negative Image'
      AllowAllUp = True
      GroupIndex = 3
      Caption = 'Neg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Margin = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Spacing = 0
      Transparent = False
      OnClick = NegColTablClick
    end
    object tlPixRange: TLabel
      Left = 63
      Top = 89
      Width = 36
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Range'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = tlPixRangeMouseDown
      OnMouseEnter = tlPixRangeMouseEnter
      OnMouseLeave = tlPixRangeMouseLeave
    end
    object SetRange: TSpeedButton
      Left = 109
      Top = 86
      Width = 26
      Height = 21
      Hint = 'Get Range'
      Caption = 'Get'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Margin = 0
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SetRangeClick
    end
    object AutoSetRange: TSpeedButton
      Left = 139
      Top = 86
      Width = 30
      Height = 21
      Hint = 'Gets Range Automatically on Loading File'
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Auto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Margin = 0
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object ZoomRange: TSpeedButton
      Left = 170
      Top = 86
      Width = 15
      Height = 21
      Hint = 'Help -  Right Mouse Button'
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'S'
      Margin = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = ZoomRangeClick
      OnMouseDown = ZoomRangeMouseDown
    end
    object lbDiamMesRectWidth: TLabel
      Left = 241
      Top = 455
      Width = 15
      Height = 16
      Caption = 'W:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Visible = False
    end
    object sbSmoothNonRatioChOne: TSpeedButton
      Left = 226
      Top = 367
      Width = 25
      Height = 17
      Hint = 'Enable Smoothing of Ch 1 Non Ratioed Image'
      AllowAllUp = True
      GroupIndex = 6
      Caption = 'Ch1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbSmoothNonRatioChOneClick
    end
    object ubBoxSmooth3x3: TUniButton
      Tag = 3
      Left = 142
      Top = 324
      Width = 24
      Height = 18
      Caption = '3x3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '3x3'
      CaptionSel = '3x3'
      GroupIndex = 10
      Kind = FlatFrame
      OnSelect = ubBoxSmooth3x3Select
    end
    object ubBoxSmooth5x5: TUniButton
      Tag = 5
      Left = 169
      Top = 324
      Width = 24
      Height = 18
      Caption = '5x5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '5x5'
      CaptionSel = '5x5'
      GroupIndex = 10
      Kind = FlatFrame
      OnSelect = ubBoxSmooth5x5Select
    end
    object ubBoxSmooth7x7: TUniButton
      Tag = 7
      Left = 196
      Top = 324
      Width = 24
      Height = 18
      Caption = '7x7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '7x7'
      CaptionSel = '7x7'
      GroupIndex = 10
      Kind = FlatFrame
      OnSelect = ubBoxSmooth7x7Select
    end
    object ubMedSmooth3x3: TUniButton
      Tag = 3
      Left = 142
      Top = 366
      Width = 24
      Height = 18
      Caption = '3x3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '3x3'
      CaptionSel = '3x3'
      GroupIndex = 11
      Kind = FlatFrame
      OnSelect = ubMedSmooth3x3Select
    end
    object ubMedSmooth5x5: TUniButton
      Tag = 5
      Left = 169
      Top = 366
      Width = 24
      Height = 18
      Caption = '5x5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '5x5'
      CaptionSel = '5x5'
      GroupIndex = 11
      Kind = FlatFrame
      OnSelect = ubMedSmooth5x5Select
    end
    object ubMedSmooth7x7: TUniButton
      Tag = 7
      Left = 196
      Top = 366
      Width = 24
      Height = 18
      Caption = '7x7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '7x7'
      CaptionSel = '7x7'
      GroupIndex = 11
      Kind = FlatFrame
      OnSelect = ubMedSmooth7x7Select
    end
    object unGaussSmooth3x3L: TUniButton
      Tag = 1
      Left = 142
      Top = 343
      Width = 24
      Height = 18
      Caption = '3L'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '3L'
      CaptionSel = '3L'
      GroupIndex = 12
      Kind = FlatFrame
      OnSelect = unGaussSmooth3x3LSelect
    end
    object unGaussSmooth5x5: TUniButton
      Tag = 5
      Left = 223
      Top = 343
      Width = 24
      Height = 18
      Caption = '5x5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '5x5'
      CaptionSel = '5x5'
      GroupIndex = 12
      Kind = FlatFrame
      OnSelect = unGaussSmooth5x5Select
    end
    object unGaussSmooth7x7: TUniButton
      Tag = 7
      Left = 250
      Top = 343
      Width = 24
      Height = 18
      Caption = '7x7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '7x7'
      CaptionSel = '7x7'
      GroupIndex = 12
      Kind = FlatFrame
      OnSelect = unGaussSmooth7x7Select
    end
    object unGaussSmooth3x3M: TUniButton
      Tag = 2
      Left = 169
      Top = 343
      Width = 24
      Height = 18
      Caption = '3M'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '3M'
      CaptionSel = '3M'
      GroupIndex = 12
      Kind = FlatFrame
      OnSelect = unGaussSmooth3x3MSelect
    end
    object unGaussSmooth3x3H: TUniButton
      Tag = 3
      Left = 196
      Top = 343
      Width = 24
      Height = 18
      Caption = '3H'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = '3H'
      CaptionSel = '3H'
      GroupIndex = 12
      Kind = FlatFrame
      OnSelect = unGaussSmooth3x3HSelect
    end
    object lblBottom: TLabel
      Left = 61
      Top = 172
      Width = 41
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Bottom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lblBottomMouseDown
      OnMouseEnter = lblBottomMouseEnter
      OnMouseLeave = lblBottomMouseLeave
    end
    object sbSmoothNonRatioChTwo: TSpeedButton
      Left = 250
      Top = 367
      Width = 25
      Height = 17
      Hint = 'Enable Smoothing of Ch 2 Non Ratioed Image'
      AllowAllUp = True
      GroupIndex = 7
      Caption = 'Ch2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbSmoothNonRatioChTwoClick
    end
    object ubSizeBar: TUniButton
      Left = 5
      Top = 434
      Width = 29
      Height = 11
      Hint = 'Show Scale Bar'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ubSizeBarClick
      ImageNotSel.Data = {
        CA020000424DCA020000000000003600000028000000130000000B0000000100
        18000000000094020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000}
      ImageSel.Data = {
        CA020000424DCA020000000000003600000028000000130000000B0000000100
        18000000000094020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000}
      ImageHot.Data = {
        CA020000424DCA020000000000003600000028000000130000000B0000000100
        18000000000094020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000}
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      ColorHot = 15717318
      ColorNotSel = clBtnFace
      ColorHotEnabled = False
      Kind = CheckSingleBevel
    end
    object ub1stChannel: TUniButton
      Left = 67
      Top = 11
      Width = 29
      Height = 25
      Caption = 'Ch1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = 'Ch1'
      CaptionSel = 'Ch1'
      ColorHot = 15717318
      ColorNotSel = clBtnFace
      GroupIndex = 9
      Selected = True
      OnSelect = ub1stChannelSelect
    end
    object ub2ndChannel: TUniButton
      Left = 67
      Top = 36
      Width = 29
      Height = 25
      Caption = 'Ch2'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      AllowDeSelect = False
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = 'Ch2'
      CaptionSel = 'Ch2'
      ColorHot = 15717318
      ColorNotSel = clBtnFace
      GroupIndex = 9
      OnSelect = ub2ndChannelSelect
    end
    object ubRatioOn: TUniButton
      Left = 5
      Top = 342
      Width = 33
      Height = 25
      Hint = 'Enable F/Fo image (Help -  Right Mouse Button)'
      Caption = 'F/Fo'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ubRatioOnClick
      OnMouseDown = ubRatioOnMouseDown
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = 'F/Fo'
      CaptionSel = 'F/Fo'
      ColorHot = 15717318
      ColorNotSel = clBtnFace
      Kind = CheckSingleBevel
    end
    object ubApplyFrame: TUniButton
      Left = 39
      Top = 431
      Width = 17
      Height = 17
      Hint = 'Apply Selection frame (Help -  Right Mouse Button)'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ubApplyFrameClick
      OnMouseDown = ubApplyFrameMouseDown
      BevelColors = SystemColors
      ImageNotSel.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000}
      ImageSel.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFF00FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF00FFFFFF000000FFFFFF00FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000FF0000FF00FFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000}
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      ColorHot = 15717318
      ColorSel = clBtnFace
      ColorNotSel = clSilver
      ColorHotEnabled = False
      Kind = CheckSingleBevel
    end
    object ubGrid: TUniButton
      Left = 62
      Top = 431
      Width = 17
      Height = 17
      Hint = 'Show Grid'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ubGridClick
      ImageNotSel.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000}
      ImageSel.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000}
      ImageHot.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
        FF000000FFFFFF000000FFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000}
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      ColorHot = 15717318
      ColorNotSel = clBtnFace
      ColorHotEnabled = False
      Kind = CheckSingleBevel
    end
    object sbSetROItracking: TSpeedButton
      Left = 213
      Top = 429
      Width = 62
      Height = 19
      AllowAllUp = True
      GroupIndex = 101
      Caption = 'Track ROI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = sbSetROItrackingClick
    end
    object lbXtol: TLabel
      Left = 138
      Top = 431
      Width = 12
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Xt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lbXtolMouseDown
    end
    object lbYtol: TLabel
      Left = 178
      Top = 431
      Width = 11
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = 'Yt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lbYtolMouseDown
    end
    object unChDivCh: TUniButton
      Left = 5
      Top = 371
      Width = 51
      Height = 25
      Hint = 'Enable F/Fo image (Help -  Right Mouse Button)'
      Caption = 'Ch1/Ch2'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = unChDivChClick
      OnMouseDown = ubRatioOnMouseDown
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      CaptionHot = 'Ch/Ch'
      CaptionSel = 'Ch/Ch'
      ColorHot = 15717318
      ColorNotSel = clBtnFace
      Kind = CheckSingleBevel
    end
    object Label2: TLabel
      Left = 188
      Top = 241
      Width = 7
      Height = 15
      Hint = 'Help -  Right Mouse Button'
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = lblBkgMouseDown
    end
    object ubFileColTable: TUniButton
      Left = 242
      Top = 192
      Width = 35
      Height = 22
      Hint = 'Enable File Own Color Table'
      BiDiMode = bdLeftToRight
      Caption = 'CTF'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ubFileColTableClick
      BevelColors = SystemColors
      ImNotSelScale = 1.000000000000000000
      ImSelScale = 1.000000000000000000
      ImHotScale = 1.000000000000000000
      ImNotSelTransparent = False
      ImSelTransparent = False
      ImHotTransparent = False
      ColorSel = clBtnFace
      ColorNotSel = clBtnFace
      ColorHotEnabled = False
      Kind = CheckSingleBevel
      Layout = blGlyphBottom
      Margin = 5
      Spacing = 16
    end
    object trbBrightness: TTrackBar
      Left = 102
      Top = 131
      Width = 137
      Height = 17
      Hint = 'Shif Color Table'
      Max = 250
      Min = -250
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 0
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbBrightnessChange
    end
    object trbContrast: TTrackBar
      Left = 102
      Top = 111
      Width = 139
      Height = 17
      Hint = 'Stretch Top'
      Max = 255
      Min = 5
      ParentShowHint = False
      PageSize = 1
      Position = 255
      ShowHint = True
      TabOrder = 1
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbContrastChange
    end
    object trbGamma: TTrackBar
      Left = 102
      Top = 151
      Width = 137
      Height = 17
      Hint = 'Gamma'
      Max = 50
      Min = 1
      ParentShowHint = False
      PageSize = 1
      Position = 10
      ShowHint = True
      TabOrder = 2
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbGammaChange
    end
    object ColorTables: TComboBox
      Left = 108
      Top = 192
      Width = 128
      Height = 22
      Hint = 'Color Tables'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemIndex = 0
      ParentFont = False
      TabOrder = 3
      Text = 'Grayscale'
      OnChange = ColorTablesChange
      OnSelect = ColorTablesChange
      Items.Strings = (
        'Grayscale'
        'Topographic'
        'Topographic Bright'
        'Topo Bright &  Yelow'
        'Rainbow'
        'Rainbow Bright'
        'Fluo-4 (516 nM)'
        'B - G - Y - R'
        'Fire'
        'Red'
        'Green'
        'Blue')
    end
    object chbBox: TCheckBox
      Left = 103
      Top = 324
      Width = 33
      Height = 18
      Hint = 'Help -  Right Mouse Button'
      Alignment = taLeftJustify
      Caption = 'B'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = chbBoxClick
      OnMouseDown = chbBoxMouseDown
    end
    object trbMaxRatio: TTrackBar
      Left = 103
      Top = 220
      Width = 137
      Height = 17
      Hint = 'Maximal F/Fo'
      Max = 300
      Min = 10
      ParentShowHint = False
      PageSize = 1
      Position = 100
      ShowHint = True
      TabOrder = 5
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbMaxRatioChange
    end
    object trbBackSubtr: TTrackBar
      Left = 102
      Top = 240
      Width = 45
      Height = 17
      Hint = 'Main Window Background Subtraction'
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 6
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbBackSubtrChange
    end
    object trbCutOff: TTrackBar
      Left = 102
      Top = 260
      Width = 137
      Height = 17
      Hint = 'Cutoff'
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 7
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbCutOffChange
    end
    object ToolsToolBar: TToolBar
      Left = 5
      Top = 450
      Width = 225
      Height = 27
      Align = alNone
      AutoSize = True
      ButtonHeight = 25
      ButtonWidth = 25
      Color = clMedGray
      DisabledImages = TollsImageList
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      Images = TollsImageList
      ParentColor = False
      TabOrder = 8
      Transparent = False
      object Select: TToolButton
        Left = 0
        Top = 0
        Hint = 'Select (Help -  Right Mouse Button)'
        Caption = 'Select'
        Grouped = True
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = SelectClick
        OnMouseDown = SelectMouseDown
      end
      object SelectLocked: TToolButton
        Left = 25
        Top = 0
        Hint = 'Select all (Help -  Right Mouse Button)'
        Caption = 'Calibration Bar'
        Grouped = True
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = SelectLockedClick
        OnMouseDown = SelectLockedMouseDown
      end
      object PlaceMark: TToolButton
        Left = 50
        Top = 0
        Hint = 'Mark (Help -  Right Mouse Button)'
        Caption = 'PlaceMark'
        Grouped = True
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = PlaceMarkClick
        OnMouseDown = PlaceMarkMouseDown
      end
      object PutBox: TToolButton
        Left = 75
        Top = 0
        Hint = 'Rectangle ROI (Help -  Right Mouse Button)'
        Caption = 'PutBox'
        Grouped = True
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = PutBoxClick
        OnMouseDown = PutBoxMouseDown
      end
      object Freehand: TToolButton
        Left = 100
        Top = 0
        Hint = 'Freehand ROI (Help -  Right Mouse Button)'
        Caption = 'Freehand'
        Grouped = True
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = FreehandClick
        OnMouseDown = FreehandMouseDown
      end
      object SelectionFrameChange: TToolButton
        Left = 125
        Top = 0
        Hint = 'Frame Adjustment (Help -  Right Mouse Button)'
        Caption = 'Select Area'
        Grouped = True
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = SelectionFrameChangeClick
        OnMouseDown = SelectionFrameChangeMouseDown
      end
      object MeasureDistance: TToolButton
        Left = 150
        Top = 0
        Hint = 'Measure Line'
        Caption = 'Measure Distance'
        Grouped = True
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = MeasureDistanceClick
      end
      object LineScanPlotRange: TToolButton
        Left = 175
        Top = 0
        Hint = 'Line Scan ROI Width'
        Caption = 'LineScanPlotRange'
        Grouped = True
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = LineScanPlotRangeClick
      end
      object MeasureBox: TToolButton
        Left = 200
        Top = 0
        Hint = 'Place at maximum (Help -  Right Mouse Button)'
        Caption = 'MeasureBox'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = MeasureBoxClick
        OnMouseDown = MeasureBoxMouseDown
      end
    end
    object chbMedian: TCheckBox
      Left = 103
      Top = 367
      Width = 33
      Height = 17
      Hint = 'Help -  Right Mouse Button'
      Alignment = taLeftJustify
      Caption = 'M'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = chbMedianClick
      OnMouseDown = chbMedianMouseDown
    end
    object ToolBarWhiteBottom: TToolBar
      Left = 248
      Top = 3
      Width = 23
      Height = 65
      Align = alNone
      AutoSize = True
      ButtonHeight = 21
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      Images = ImageListResWBl
      TabOrder = 10
      object BlackBottom: TToolButton
        Left = 0
        Top = 0
        Hint = 'Set pixels with Zero values to black in any color table'
        Caption = 'BlackBottom'
        ImageIndex = 2
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        Style = tbsCheck
        OnClick = BlackBottomClick
      end
      object ResetColTbl: TToolButton
        Left = 0
        Top = 21
        Hint = 'Reset Color Table'
        Caption = 'ResetColTbl'
        ImageIndex = 0
        ParentShowHint = False
        Wrap = True
        ShowHint = True
        OnClick = ResetColTblClick
      end
      object WhiteBottom: TToolButton
        Left = 0
        Top = 42
        Hint = 'Set pixels with Zero values to white in any color table'
        Caption = 'WhiteBottom'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = WhiteBottomClick
      end
    end
    object scrBoxXsize: TScrollBar
      Left = 23
      Top = 516
      Width = 143
      Height = 11
      Hint = 'X of ROI'
      Max = 10
      Min = 1
      PageSize = 1
      ParentShowHint = False
      Position = 10
      ShowHint = True
      TabOrder = 11
      OnChange = scrBoxXsizeChange
      OnMouseEnter = scrBoxXsizeMouseEnter
      OnMouseLeave = scrBoxXsizeMouseLeave
    end
    object scrBoxYSize: TScrollBar
      Left = 23
      Top = 531
      Width = 143
      Height = 11
      Hint = 'Y of ROI'
      Max = 10
      Min = 1
      PageSize = 1
      ParentShowHint = False
      Position = 10
      ShowHint = True
      TabOrder = 12
      OnChange = scrBoxYSizeChange
      OnMouseEnter = scrBoxYSizeMouseEnter
      OnMouseLeave = scrBoxYSizeMouseLeave
    end
    object trbTransp: TTrackBar
      Left = 102
      Top = 280
      Width = 137
      Height = 17
      Hint = 'Change Transparency of Average Image'
      Max = 255
      Min = 25
      ParentShowHint = False
      PageSize = 1
      Position = 255
      ShowHint = True
      TabOrder = 13
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbTranspChange
    end
    object DSPixRange: TDSlider
      Left = 61
      Top = 71
      Width = 216
      Height = 11
      Enabled = False
      Constraints.MinHeight = 5
      Constraints.MinWidth = 70
      Color = clBtnFace
      ColorSlider = 16761220
      ColorThumb = clBtnFace
      ColorTrack = 16770250
      ColorContour = clBlue
      Flat = False
      Frame = True
      Contour = True
      ThumbSize = 8
      Kind = Horizontal
      Min = 0
      Max = 1023
      PosFrom = 0
      PosTo = 1023
      Delta = 255
      Depressible = True
      AllowTimer = True
      OnChange = DSPixRangeChange
    end
    object enPixRange: TEditNumerical
      Left = 191
      Top = 88
      Width = 87
      Height = 16
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      Enabled = False
      MaxLength = 11
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 15
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = 16773599
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'MS Sans Serif'
      FontOnFocus.Style = [fsBold]
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'MS Sans Serif'
      FontOnNoFocus.Style = [fsBold]
      Max = 1023.000000000000000000
      Delta = 255
      Numbers = Two
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enPixRangeReturnPressed
    end
    object ActionsToolBar: TToolBar
      Left = 5
      Top = 479
      Width = 272
      Height = 27
      Align = alNone
      ButtonHeight = 25
      ButtonWidth = 25
      Color = clMedGray
      DisabledImages = TollsImageList
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = False
      Images = TollsImageList
      ParentColor = False
      TabOrder = 16
      Transparent = False
      object DeleteAll: TToolButton
        Left = 0
        Top = 0
        Hint = 'Delete all ROI'
        Caption = 'DeleteAll'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = DeleteAllClick
      end
      object btZeroOutsideROI_AvIm: TToolButton
        Left = 25
        Top = 0
        Hint = 
          'Zeroes outside ROI in Average image  (Help -  Right Mouse Button' +
          ')'
        Caption = 'btZeroOutsideROI_AvIm'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = MakeOutZero
        OnMouseDown = btZeroOutsideROI_AvImMouseDown
      end
      object btZeroOutsideROI_All_Images: TToolButton
        Left = 50
        Top = 0
        Hint = 'Zeroes Outside ROI in Main Image  (Help -  Right Mouse Button)'
        Caption = 'btZeroOutsideROI_All_Images'
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = btZeroOutsideROI_All_ImagesClick
        OnMouseDown = btZeroOutsideROI_All_ImagesMouseDown
      end
      object GetROISurface: TToolButton
        Left = 75
        Top = 0
        Hint = 'Get Surface of Freehand ROIs'
        Caption = 'GetROISurface'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = GetROISurfaceClick
      end
      object DoLineScan: TToolButton
        Left = 100
        Top = 0
        Hint = 'Do Line Scan'
        Caption = 'DoLineScan'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = DoLineScanClick
      end
      object DeleteMesLine: TToolButton
        Left = 125
        Top = 0
        Hint = 'Delete Measure Line'
        Caption = 'DeleteMesLine'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = DeleteMesLineClick
      end
      object TransferLStoPlot: TToolButton
        Left = 150
        Top = 0
        Hint = 'Transfer LS Trace to Plot'
        AutoSize = True
        Caption = 'TransferLStoPlot'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = TransferLStoPlotClick
      end
      object DiamMes: TToolButton
        Left = 175
        Top = 0
        Caption = 'DiamMes'
        ImageIndex = 16
        Style = tbsCheck
        OnClick = DiamMesClick
      end
      object ubSetDiamMes: TUniButton
        Left = 200
        Top = 0
        Width = 71
        Height = 25
        Caption = 'Unlocked'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
        OnClick = ubSetDiamMesClick
        ImageSel.Data = {
          46050000424D4605000000000000360000002800000012000000120000000100
          2000000000001005000000000000000000000000000000000000C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C3C8C700A1ABAB0083929500D9DAD600C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00E3E2EB00CED1D60096A1
          A500586A7B001C3452000D259500142DB9000F29D10064778600D6CBC700C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00999999000D1D81001026
          B4000823DF00002AD500002FD500073CE000184BF9001D4DFF000B37F00074AB
          FF002442C900BFBABB00C4FFFF00C4FFFF00C4FFFF00C4FFFF00E4F0F2000927
          D900003CEE001242FF001A45E80000030F00113ECF00124CF9001648FE00194B
          FC001143F10089B6FF002158FB007D909500C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00D7EBF6000027D500003FFF00003DFF00001A7B000D0C0000000F57001046
          FF001A4CFD001D4FFD001849F30084B2FF001E55FE006E7E8E00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00D5E8EB000432D7000C45FC000844FC0000050E000005
          0000000011001B50FF001D4FFD002253FD001F4FF5007CABFC001B51FF006776
          9000C4FFFF00C4FFFF00C4FFFF00C4FFFF00CFDBE1000436EC000D3EFF000A43
          FD0006144500020007001E2673001E51ED00285BF8003A6FFC002F58FB00749E
          F700244DFF0061689300C4FFFF00C4FFFF00C4FFFF00C4FFFF00C7D4DC00083C
          F4001145FF000D4BF50000132C000607000000022B002A5EF800386EFB00467D
          FE003A64FD006E99F600214BFF005A629100C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00BECDD6000B41FA000B3FFE000A43FD00040F480002000A002C338200407B
          FF004882FF004B84F8004571FF006893F4001D47FF00555C8E00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00A3AED4000047EF00184AFB001F4EFE002A55FF002F5E
          D200528AFF005FA1F20088BCFF00A8DBFB00BADAFF00173BB1002046E0003545
          8000C4FFFF00C4FFFF00C4FFFF00C4FFFF00AAB0E5000848FF003874FF004481
          FF005594FF0087BBFE0098C2FF009ECCFF0091C6FF0092C4F8006481E4000015
          7400000C6B0041497800C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF000A37
          CE00012DE400002CD7000021BE00001A9C000A1A8B0000128400030B64005157
          7C005A5759000B1D5E0012255800FFFCE300C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF0079747300EDE8E500C5C6C200C4FFFF00C4FF
          FF00D6D8E000C3C1C100605A5300C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00716F6700EAE8DE00A29F
          A800C4FFFF00C4FFFF0075777100E1E1DB004B464300C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00E2DD
          DA00A39D980079727500898384007B767500E6E2E1007A777300B5B2AD00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF006F6F6F00A5A19C00938F8A00E8E4DF00767271003A38
          3700C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00ECECEC00736D6600A49E9700827C
          750042403F00E1E2E000C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00F3F8F700EFF4F300C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
          FF00C4FFFF00C4FFFF00}
        ImNotSelScale = 1.000000000000000000
        ImSelScale = 1.000000000000000000
        ImHotScale = 1.000000000000000000
        ColorHotEnabled = False
        Kind = FlatFrame
        OnSelect = ubSetDiamMesSelect
      end
    end
    object rbBoxOrGaussSm2DFirst: TRadioButton
      Left = 62
      Top = 334
      Width = 35
      Height = 17
      Alignment = taLeftJustify
      Caption = '1st'
      TabOrder = 17
      OnClick = rbBoxOrGaussSm2DFirstClick
    end
    object rbMedSm2DFirst: TRadioButton
      Left = 62
      Top = 367
      Width = 35
      Height = 17
      Alignment = taLeftJustify
      Caption = '1st'
      TabOrder = 18
      OnClick = rbMedSm2DFirstClick
    end
    object enDiamMesRectWidth: TEditNumerical
      Tag = 5
      Left = 258
      Top = 454
      Width = 19
      Height = 19
      Ctl3D = False
      MaxLength = 2
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 19
      Text = '5'
      Visible = False
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
      Max = 99.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enDiamMesRectWidthReturnPressed
    end
    object trbBottomRegionOfColorTable: TTrackBar
      Left = 102
      Top = 171
      Width = 137
      Height = 17
      Hint = 'Change Bottom of Color Table'
      Enabled = False
      Max = 255
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 20
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbBottomRegionOfColorTableChange
    end
    object chbGauss: TCheckBox
      Left = 103
      Top = 343
      Width = 33
      Height = 18
      Hint = 'Help -  Right Mouse Button'
      Alignment = taLeftJustify
      Caption = 'G'
      Color = clMedGray
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      OnClick = chbGaussClick
      OnMouseDown = chbGaussMouseDown
    end
    object cbSmoothBeforeDoRatio: TCheckBox
      Left = 123
      Top = 388
      Width = 153
      Height = 18
      Hint = 'Smooth Before Doing Ratio'
      Caption = 'Smooth before  F/Fo'
      Checked = True
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 22
      OnClick = cbSmoothBeforeDoRatioClick
      OnMouseDown = chbBoxMouseDown
    end
    object cbDoLineScanOfMergeImage: TCheckBox
      Left = 123
      Top = 409
      Width = 155
      Height = 16
      Hint = 'Help -  Right Mouse Button'
      Caption = 'LineScan = Merge Image'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
      OnClick = cbDoLineScanOfMergeImageClick
      OnMouseDown = cbDoLineScanOfMergeImageMouseDown
    end
    object cbMergeModel: TComboBox
      Left = 40
      Top = 298
      Width = 78
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
      Text = 'Merge'
      OnChange = cbMergeModelChange
      Items.Strings = (
        'Merge'
        'Overlay Ch1'
        'Overlay Ch2')
    end
    object trbOverlayThreshold: TTrackBar
      Left = 119
      Top = 301
      Width = 120
      Height = 17
      Hint = 'Overlay Threshold'
      Max = 255
      ParentShowHint = False
      PageSize = 1
      Position = 10
      ShowHint = True
      TabOrder = 25
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbOverlayThresholdChange
    end
    object enContrast: TEditNumerical
      Left = 247
      Top = 111
      Width = 29
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 3
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 26
      Text = '255'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Min = 5.000000000000000000
      Max = 255.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enContrastReturnPressed
    end
    object enBrightness: TEditNumerical
      Left = 247
      Top = 131
      Width = 29
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 4
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 27
      Text = '0'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Min = -250.000000000000000000
      Max = 250.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enBrightnessReturnPressed
    end
    object enGamma: TEditNumerical
      Left = 247
      Top = 151
      Width = 29
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 4
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 28
      Text = '1.0'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Min = 0.100000000000000000
      Max = 5.000000000000000000
      Delta = 0
      NumberKind = Floats
      WaitTime = 5000
      Precision = 1
      OnReturnPressed = enGammaReturnPressed
    end
    object enBottomRegionOfColorTable: TEditNumerical
      Left = 247
      Top = 171
      Width = 29
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      Enabled = False
      MaxLength = 3
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 29
      Text = '0'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Max = 255.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enBottomRegionOfColorTableReturnPressed
    end
    object enMaxRatio: TEditNumerical
      Left = 237
      Top = 220
      Width = 39
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 4
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 30
      Text = '2.00'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Min = 0.100000000000000000
      Max = 3.000000000000000000
      Delta = 0
      NumberKind = Floats
      WaitTime = 5000
      Precision = 2
      OnReturnPressed = enMaxRatioReturnPressed
    end
    object enCutOff: TEditNumerical
      Left = 237
      Top = 260
      Width = 39
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 5
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 31
      Text = '0'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Max = 255.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enCutOffReturnPressed
    end
    object enBackSubtrMainWindow: TEditNumerical
      Left = 145
      Top = 240
      Width = 39
      Height = 17
      Hint = 'Main Window Background Subtraction'
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 4
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 32
      Text = '0'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Max = 255.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enBackSubtrMainWindowReturnPressed
    end
    object enTransp: TEditNumerical
      Left = 237
      Top = 280
      Width = 39
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 3
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 33
      Text = '100'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Max = 100.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enTranspReturnPressed
    end
    object enOverlayThreshold: TEditNumerical
      Left = 237
      Top = 301
      Width = 39
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 3
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 34
      Text = '10'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Max = 255.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enOverlayThresholdReturnPressed
    end
    object enROItrackXtol: TEditNumerical
      Tag = 5
      Left = 152
      Top = 429
      Width = 20
      Height = 19
      Ctl3D = False
      MaxLength = 2
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 35
      Text = '20'
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
      Max = 99.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enROItrackXtolReturnPressed
    end
    object enROItrackYtol: TEditNumerical
      Tag = 5
      Left = 192
      Top = 429
      Width = 20
      Height = 19
      Ctl3D = False
      MaxLength = 2
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 36
      Text = '20'
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
      Max = 99.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enROItrackYtolReturnPressed
    end
    object trbBack2ndWinSubtr: TTrackBar
      Left = 195
      Top = 240
      Width = 45
      Height = 17
      Hint = 'Secondary Window Background Subtraction'
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 37
      ThumbLength = 15
      TickStyle = tsNone
      OnChange = trbBack2ndWinSubtrChange
    end
    object enBackSubtr2ndWindow: TEditNumerical
      Left = 237
      Top = 240
      Width = 39
      Height = 17
      Hint = 'Secondary Window Background Subtraction'
      AutoSize = False
      BorderStyle = bsNone
      Ctl3D = False
      MaxLength = 4
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 38
      Text = '0'
      HideText = False
      Alignment = taCenter
      ColorOnFocus = 12910591
      ColorOnNoFocus = clWhite
      FontOnFocus.Charset = DEFAULT_CHARSET
      FontOnFocus.Color = clWindowText
      FontOnFocus.Height = -13
      FontOnFocus.Name = 'Microsoft Sans Serif'
      FontOnFocus.Style = []
      FontOnNoFocus.Charset = DEFAULT_CHARSET
      FontOnNoFocus.Color = clWindowText
      FontOnNoFocus.Height = -13
      FontOnNoFocus.Name = 'Microsoft Sans Serif'
      FontOnNoFocus.Style = []
      Max = 255.000000000000000000
      Delta = 0
      WaitTime = 5000
      Precision = 0
      OnReturnPressed = enBackSubtr2ndWindowReturnPressed
    end
  end
  object TollsImageList: TImageList
    Height = 18
    Masked = False
    Width = 18
    Left = 240
    Top = 646
    Bitmap = {
      494C010112001300D40312001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000005A00000001002000000000004065
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00C3C8C700A1ABAB0083929500D9DAD600C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00E3E2EB00CED1D60096A1A500586A7B001C34
      52000D259500142DB9000F29D10064778600D6CBC700C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008000000080000000C0C0
      C000000000008080800080000000800000008000000080000000800000008000
      0000C0C0C0000000000000000000000000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00999999000D1D81001026B4000823DF00002AD500002FD500073C
      E000184BF9001D4DFF000B37F00074ABFF002442C900BFBABB00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000C0C0C0000000000000000000C0C0C0008000
      0000800000008000000000000000000000000000000000000000C4FFFF00C4FF
      FF00E4F0F2000927D900003CEE001242FF001A45E80000030F00113ECF00124C
      F9001648FE00194BFC001143F10089B6FF002158FB007D909500C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C0008000
      0000800000008080800000000000000000000000000000000000000000000000
      0000C0C0C0008000000080000000000000000000000000000000C4FFFF00C4FF
      FF00D7EBF6000027D500003FFF00003DFF00001A7B000D0C0000000F57001046
      FF001A4CFD001D4FFD001849F30084B2FF001E55FE006E7E8E00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080808000000000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000C4FFFF00C4FF
      FF00D5E8EB000432D7000C45FC000844FC0000050E0000050000000011001B50
      FF001D4FFD002253FD001F4FF5007CABFC001B51FF0067769000C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000800000008080
      8000000000008000000080000000808080000000000000000000000000000000
      0000000000000000000080808000800000008080800000000000C4FFFF00C4FF
      FF00CFDBE1000436EC000D3EFF000A43FD0006144500020007001E2673001E51
      ED00285BF8003A6FFC002F58FB00749EF700244DFF0061689300C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000080000000800000008080800000000000000000000000
      0000000000000000000000000000800000008000000000000000C4FFFF00C4FF
      FF00C7D4DC00083CF4001145FF000D4BF50000132C000607000000022B002A5E
      F800386EFB00467DFE003A64FD006E99F600214BFF005A629100C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000800000008000000080000000000000000000
      0000000000000000000000000000800000008000000000000000C4FFFF00C4FF
      FF00BECDD6000B41FA000B3FFE000A43FD00040F480002000A002C338200407B
      FF004882FF004B84F8004571FF006893F4001D47FF00555C8E00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000008080800080000000800000000000
      0000000000000000000000000000800000008000000000000000C4FFFF00C4FF
      FF00A3AED4000047EF00184AFB001F4EFE002A55FF002F5ED200528AFF005FA1
      F20088BCFF00A8DBFB00BADAFF00173BB1002046E00035458000C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000080808000800000008000
      0000000000000000000000000000800000008000000000000000C4FFFF00C4FF
      FF00AAB0E5000848FF003874FF004481FF005594FF0087BBFE0098C2FF009ECC
      FF0091C6FF0092C4F8006481E40000157400000C6B0041497800C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000800000008080
      8000000000000000000000000000000000000000000000000000808080008000
      0000800000000000000080808000800000008080800000000000C4FFFF00C4FF
      FF00C4FFFF000A37CE00012DE400002CD7000021BE00001A9C000A1A8B000012
      8400030B640051577C005A5759000B1D5E0012255800FFFCE300C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000800000008000000080000000800000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF0079747300EDE8E500C5C6C200C4FFFF00C4FF
      FF00D6D8E000C3C1C100605A5300C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      000080000000C0C0C00000000000000000000000000000000000000000000000
      0000808080008000000080000000C0C0C0000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00716F6700EAE8DE00A29FA800C4FFFF00C4FF
      FF0075777100E1E1DB004B464300C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000C0C0C0000000000000000000C0C0C0008000
      0000800000008000000080000000800000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00E2DDDA00A39D980079727500898384007B76
      7500E6E2E1007A777300B5B2AD00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00080000000800000008000000080000000800000008000
      00008080800000000000C0C0C000800000008000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF006F6F6F00A5A19C00938F8A00E8E4
      DF00767271003A383700C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00ECECEC00736D6600A49E9700827C
      750042403F00E1E2E000C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4FFFF00C4FF
      FF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00F3F8F700EFF4
      F300C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FFFF00C4FF
      FF00000000000000000000000000000000000000000000000000000000000000
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
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF0000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000009900000099000000990000009900
      0000990000009900000099000000000000000000000000000000000000000000
      0000990000009900000099000000990000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000009900000099000000990000009900
      0000990000009900000099000000000000000000000000000000000000009900
      0000990000009900000099000000990000009900000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000FF0000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000990000009900
      0000990000000000000000000000990000009900000099000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000009900000099000000990000009900000099000000990000009900
      000099000000990000000000000000000000000000000000000000000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000990000009900
      0000000000000000000000000000000000009900000099000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000009900000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      FF00000000000000FF00000000000000FF009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009900000099000000990000009900
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000FF000000000000000000990000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099000000990000009900000099000000990000009900
      00000000000000000000990000000000FF000000FF000000FF00000000000000
      000000000000000000000000FF000000FF000000000000000000990000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000000000009900
      0000990000009900000099000000990000009900000000000000990000009900
      0000990000009900000099000000990000000000FF000000FF000000FF000000
      0000000000000000FF000000FF00990000009900000099000000990000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000990000009900
      0000990000009900000099000000000000000000000000000000990000009900
      000099000000990000009900000099000000990000000000FF000000FF000000
      FF000000FF000000FF0099000000990000009900000099000000990000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000990000009900
      0000000000000000000000000000000000000000000000000000990000009900
      00000000000000000000990000000000000000000000000000000000FF000000
      FF000000FF000000000000000000990000000000000000000000990000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000990000009900
      0000000000000000000000000000000000009900000099000000990000009900
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000990000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000990000009900
      0000000000000000000000000000990000009900000099000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000009900000099000000990000009900000099000000990000009900
      00009900000099000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000000000009900
      0000990000009900000099000000990000009900000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000009900000099000000990000009900000099000000990000009900
      00009900000099000000FF000000FF000000FF000000FF000000FF0000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000009900000099000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000990000009900000099000000990000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
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
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000990000006600000099000000660000009900
      0000660000009900000066000000990000006600000099000000660000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000660000009900000066000000990000006600
      0000990000006600000099000000660000009900000066000000990000006600
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000990000006600000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF009900
      0000660000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000660000009900000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00990000006600000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000990000006600000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF009900000066000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000660000009900000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00660000009900000000000000000000000000FF000000FF000000
      000000000000FF000000FF0000000000FF000000FF0000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF0000000000000000000000FF000000FF000000
      0000000000000000FF000000FF0000000000FF000000FF000000000000000000
      0000000000000000000000000000990000006600000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0066000000990000000000000000000000000000000000FF000000FF000000
      000000000000FF000000FF0000000000FF000000FF000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF0000000000000000000000FF000000FF000000
      0000000000000000FF000000FF00FF000000FF00000000000000000000000000
      0000000000000000000000000000990000009900000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF006600
      00009900000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF000000FF000000
      FF00000000000000FF000000FF0000000000FF000000FF000000000000000000
      0000000000000000000000000000990000006600000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00660000009900
      00000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000FF000000FF00FF00000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000FF000000FF000000FF000000
      FF00FF0000000000FF000000FF00000000000000000000000000FF000000FF00
      0000000000000000000000000000660000009900000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0066000000990000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000FF000000FF00FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      FF000000FF000000FF000000FF00FF000000FF000000FF000000FF000000FF00
      000000000000000000000000000000000000660000009900000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0099000000660000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      FF000000FF000000FF000000FF00FF000000FF000000FF000000FF0000000000
      00000000000000000000000000000000000000000000660000009900000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00990000006600
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000660000009900
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF009900
      0000660000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006600
      00009900000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00990000006600000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000660000009900000066000000990000006600000099000000660000009900
      0000660000009900000066000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006600000099000000990000009900000066000000990000006600
      0000990000006600000099000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000800000008000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008000000080000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080000000800000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080000000800000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000800000008000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008000000080000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000800000008000000000000000000000008000000000000000000000000000
      0000800000008000000000000000000000000000000080000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000800000008000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000800000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000008000
      000080000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000800000008000000000000000000000008000000000000000000000000000
      0000800000008000000000000000000000000000000080000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000008000
      000080000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000800000008000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      000080000000800000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      000000000000800000008000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      000000000000000000008000000080000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      000080000000800000008000000080000000800000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      000080000000800000008000000080000000800000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF00000000000000
      00000000000000000000800000008000000080000000FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF00000000000000
      00000000000080000000800000008000000000000000FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
      FF00800000008000000080000000FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      FF00800000008000000000000000FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000800000000000000000000000000000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008000000000000000000000000000000080000000FF00
      FF00800000000000000000000000FF00FF000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000008000
      0000800000000000000000000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000800000008000000000000000000000008000000080000000FF00
      FF00000000000000000000000000FF00FF000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000008000
      0000800000000000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000008000000080000000800000000000
      0000FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000480000005A0000000100010000000000380400000000000000000000
      000000000000000000000000FFFFFF00FFFFC0000000000000000000FFFFC000
      00000000000000008807C0000000000000000000C0C3C0000000000000000000
      C3F1C0000000000000000000C1FCC000000000000000000088FC400000000000
      000000009C7E400000000000000000009E3E400000000000000000009F1E4000
      00000000000000009F8E400000000000000000008FC440000000000000000000
      CFE0C0000000000000000000E3F0C0000000000000000000F0C0C00000000000
      00000000F80440000000000000000000FFFFC0000000000000000000FFFFC000
      0000000000000000FFFFFFFFFFFFFC3F80000000FFFFFFFFFFFFFC1F00000000
      01F0FFFFFFFFFFDE7F00000001E07DFFBFFFFFECFB0000003FC638FFF00003E9
      F10000003FCF387F700003F3EA0000003FFF0C7EC00003FFFB0000003FFC0C3C
      C00003FFFB0000003FE04018000003FFFB0000003FC1C000000003FFFB000000
      3FCFCDC6C00003FFFF0000003FCF0F83C00003FFFF0000003FCE3F19F000003F
      800000003FE07C3CF000001F000000003FF0F87E7FFFFFDE7F000000FFFFF8FF
      BFFFFFECFF000000FFFFFFFFFFFFFFE9FF000000FFFFFFFFFFFFFFF3FF000000
      00003FFFF00003FFFF00000000003FFFF00002001F00000000003FFFF0000200
      0F00000001FE3DFFB01FE2000700000001FE38FFF01FE2000300000001FC387F
      701FC2000100000001F83C7EF01F82000100000000703E3CF019020003000000
      00603F19F01802000700000000F03F83F00902000F000000007C3FC7F001C200
      1F00000000003F83F00003001F00000000003F19F00003800F00000000003C3C
      F00003C0070000000000387E700003E003000000000038FFB00003F001000000
      00003FFFF00003F80100000000003FFFF00003FFFF000000FFFFE0000FFFFFFF
      FF0000008007C0000FFFFE18610000008003C0000FFFFE18610000009FF9C7DF
      8FFFFE7FF90000009FFCC78F8FFFFE7FF90000009FFE47DF8FFFFFFFFF000000
      9FFE47DF83F3F3FFFF0000009FFCC7DF8373B27FF90000009FF9C5DE8000027F
      F90000009FF3C0000000027FF90000009FE7C5DE8373B27FF9000000CFE7C7DF
      83F3F3FFFF000000E7F3C7DF8FFFFFFFFF000000F3F9C78F8FFFFE7FF9000000
      F9FCC7DF8FFFFE7FF9000000FC0040000FFFFE1861000000FE0040000FFFFE18
      61000000FFFFC0000FFFFFFFFF000000FFFF3FFFCFFFFFFFFF000000FFFE3FFF
      8800060001000000FFFC7F801800060001000000FFF8FF8039FFE67FF9000000
      FFF1FFBC39F3E67FF9000000FFE3FFB8B9F3E67FF9000000FFC7FF8039F3E67F
      F9000000FF8FFFE2F9F3E67FF9000000F71FFDC6F900267FF9000000E63FF98E
      F900267FF9000000E47FF911F9F3E67FF9000000C0FFF03FF9F3E67FF9000000
      C1FFF07FF9F3E67FF9000000803FE00FF9F3E67FF9000000807FE01FF9FFE67F
      F900000081FFE07FF80006000100000007FFC1FFF8000600010000003FFFCFFF
      FFFFFFFFFF00000000000000000000000000000000000000000000000000}
  end
  object ImageListResWBl: TImageList
    Height = 15
    Left = 182
    Top = 640
    Bitmap = {
      494C010103000400D40310000F00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000000F0000000100200000000000000F
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
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000000000000000000008000
      8000800080008000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000000000000800080008000
      8000800080000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000000000000800080008000
      8000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000080008000800080008000
      800000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000008000800080008000800080000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080008000800080008000800080008000800080008000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000000000000800080008000
      8000800080000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000000000000000000008000
      800080008000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080000000000000000000000000000000000000000000800080008000
      800080008000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      8000800080008000800080008000800080008000800080008000800080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
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
      28000000400000000F0000000100010000000000780000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      E7E3F81FF81F0000E7C7E007E0070000E7CFC003C0030000E78FC003C0030000
      E71F800180010000E03F800180010000E00F800180010000E7C7800180010000
      E7E7800180010000E7C7C003C0030000E00FC003C0030000E01FE007E0070000
      FFFFF81FF81F000000000000000000000000000000000000000000000000}
  end
  object ImageListInfoRat: TImageList
    Height = 25
    Width = 25
    Left = 33
    Top = 641
    Bitmap = {
      494C010104007801580419001900FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000064000000320000000100200000000000204E
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
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000000000FFFFFF00FFFFFF00000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080000000
      0000FFFFFF00FFFFFF0000000000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      000080000000000000000000000080000000800000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000000
      0000000000008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000008000
      0000800000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100F1F1F100F1F1F100000000000000000000000000000000000000
      00000000000000000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000000000008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      000080000000000000000000000080000000800000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F1F1
      F100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000808080008080800080808000808080000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000000000008000
      0000800000000000000000000000800000008000000000000000000000008000
      0000800000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800080808000808080000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000800000008000
      0000000000000000000000000000800000008000000000000000000000008000
      000080000000000000000000000080000000800000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F1F1
      F100F1F1F100000000000000000000000000F1F1F100F1F1F100F1F1F1000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000808080008080
      8000000000000000000080000000800000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000000000008000
      0000800000000000000000000000000000008000000080000000800000008000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1F1F10000000000000000000000
      000000000000F1F1F100000000000000000000000000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C00000000000808080008080800000000000800000008000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000800000008000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F1F100F1F1F10000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000808080000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F100F1F1F1000000
      00000000000000000000F1F1F1000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080008080800000000000800000008000
      0000800000008000000080000000800000000000000000000000000000008000
      0000800000000000000000000000800000008000000080000000800000008000
      000080000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F1F1
      F100F1F1F100F1F1F100F1F1F100F1F1F1000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080000000000080000000800000008000000080000000800000008000
      0000000000000000000000000000800000008000000000000000000000008000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F1F1F100000000000000000000000000F1F1
      F1000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080008080800000000000800000008000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000800000008000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F1F1
      F100000000000000000000000000F1F1F1000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F1F1F100F1F1F10000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000808080000000000000000000800000008000
      0000800000008000000080000000800000008000000000000000000000000000
      0000800000008000000000000000800000008000000080000000800000008000
      000080000000800000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F1F100F1F1F10000000000000000000000000000000000F1F1F1000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000008000000080000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F100F1F1F100F1F1
      F100F1F1F100F1F1F100000000000000000000000000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FF000000FF00
      0000FF000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FF000000FF00
      0000FF000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000064000000320000000100010000000000200300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      FFFEFFFFFFFFE000001FFFFFF0000000FFFCFFFFFFFFC000001FFFFFF0000000
      FFF0FFFFFFFFC000001FFFFFF0000000FFF0FFFFFFFFC7FFFF1FFFFFF0000000
      FFC0FFFFFFF0C7FFFF1FFFFFF0000000FF001FFFFFE647FFFF1FFFFFF0000000
      F80007FFFFE647FFFF1FFFE010000000F80003FFFFE647FFFF1C398810000000
      F00001CFCE6647FFFF18199810000000C00000CFCE6647FFFF19898410000000
      800000CFCE70C7FFFF13D994300000008000004FE67FC7FFFF13F99230000000
      8000004FE67FC7FFFF13F9991000000000000040E607C7FFFF13F80090000000
      00000040E607C7FFFF13D928900000000000004FE67FC7FFFF1989E890000000
      0000004FF27FC7FFFF1819E410000000000000C07203C7FFFF1C39F210000000
      800001C07203C7FFFF1FFFF830000000800001FFFFFFC7FFFF1FFFFFF0000000
      C00007FFFFFFC7FFFF1FFFFFF0000000E0000FFFFFFFC7FFFF1FFFFFF0000000
      F0001FFFFFFFC000001FFFFFF0000000F8001FFFFFFFC000001FFFFFF0000000
      FF01FFFFFFFFC000001FFFFFF000000000000000000000000000000000000000
      000000000000}
  end
  object ImageListInfoRatDisAbled: TImageList
    Height = 25
    Width = 25
    Left = 231
    Top = 580
    Bitmap = {
      494C010104007801040419001900FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000064000000320000000100200000000000204E
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
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000808080008080800000000000FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000808080000000000000000000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      800080808000000000000000000080808000808080000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      000000000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800000000000000000008080
      8000808080000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F5F5F500F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400000000000000000000000000000000000000
      000000000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000000
      0000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      800080808000000000000000000080808000808080000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000080808000808080008080800080808000000000000000
      000000000000808080008080800000000000000000008080800080808000F5F5
      F500000000008080800080808000808080008080800080808000808080000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000080808000808080008080
      8000000000000000000080808000808080000000000000000000000000000000
      0000000000000000000080808000808080000000000000000000000000008080
      8000808080000000000000000000808080008080800000000000000000008080
      8000808080000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000080808000808080008080
      8000808080008080800080808000000000000000000080808000808080000000
      0000000000008080800080808000F5F5F5000000000080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000080808000808080008080800000000000808080008080
      8000000000000000000000000000000000000000000000000000808080008080
      8000000000000000000000000000808080008080800000000000000000008080
      800080808000000000000000000080808000808080000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000008080800080808000000000000000000080808000808080008080
      800000000000808080008080800000000000000000008080800080808000F5F5
      F500F4F4F40000000000808080008080800000000000F4F4F400F4F4F4000000
      00000000000080808000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000808080000000000080808000808080000000000000000000000000000000
      0000000000000000000080808000808080000000000000000000000000008080
      8000808080000000000000000000000000008080800080808000808080008080
      8000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000008080800080808000000000000000
      0000000000000000000080808000000000000000000080808000808080000000
      000000000000808080008080800000000000F5F5F50000000000808080008080
      800080808000F4F4F40000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000808080008080800000000000808080008080
      8000000000000000000000000000000000000000000000000000000000008080
      8000808080000000000000000000808080008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000808080008080800000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000080808000808080000000
      0000F5F5F500F4F4F40000000000808080008080800080808000000000000000
      000080808000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000000
      0000808080000000000080808000808080000000000000000000000000000000
      0000000000000000000000000000808080008080800000000000000000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000008080800080808000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      00000000000080808000808080000000000000000000F5F5F500F4F4F4000000
      00008080800080808000F4F4F4000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008080800000000000808080008080
      8000808080008080800080808000808080000000000000000000000000008080
      8000808080000000000000000000808080008080800080808000808080008080
      800080808000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000808080008080800000000000000000000000000000000000000000000000
      000000000000808080008080800080808000808080008080800080808000F5F5
      F500F4F4F400F4F4F400F4F4F400F4F4F4000000000080808000808080000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000808080000000000080808000808080008080800080808000808080008080
      8000000000000000000000000000808080008080800000000000000000008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000008080800080808000000000000000
      0000000000000000000080808000000000000000000080808000808080000000
      0000808080008080800000000000F5F5F500000000008080800080808000F4F4
      F400FBFBFB0080808000808080000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008080800000000000808080008080
      8000000000000000000000000000000000000000000000000000000000008080
      8000808080000000000000000000808080008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000008080800080808000000000000000000080808000808080008080
      800000000000808080008080800000000000000000000000000000000000F5F5
      F500000000008080800080808000F4F4F400FBFBFB0080808000808080000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000808080000000000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000000000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000080808000808080008080
      8000808080008080800080808000000000000000000080808000808080000000
      0000000000000000000000000000F5F5F500F4F4F40000000000808080008080
      8000808080008080800080808000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000808080000000000000000000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000808080008080800000000000808080008080800080808000808080008080
      800080808000808080000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000F5F5F500F4F4F40000000000808080008080800080808000F4F4F4000000
      00000000000080808000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FF000000FF000000FF000000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080000000000000000000000000008080800080808000000000008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F5F5F500F4F4F400F4F4
      F400F4F4F400F4F4F4000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080808000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C00080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008080800080808000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000064000000320000000100010000000000200300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      FFFE7FFFFFFFE000001FFFFFF0000000FFFC7FFFFFFFC000001FFFFFF0000000
      FFF87FFFFFFFC000001FFFFFF0000000FFE07FFFFFFFC7FFFF1FFFFFF0000000
      FF001FFFFFF0C7FFFF1FFFFFF0000000FE0007FFFFE647FFFF1FFFFFF0000000
      FC0003FFFFE647FFFF1FFFE010000000F00001FFFFE647FFFF1C398810000000
      F00000CFCE6647FFFF18198810000000E000004FCE6647FFFF19898490000000
      8000004FCE70C7FFFF13D994300000008000004FE67FC7FFFF13F99230000000
      0000004FE67FC7FFFF13F9991000000000000040E607C7FFFF13F80090000000
      00000040E607C7FFFF13D928100000000000004FE67FC7FFFF1989E810000000
      0000004FF27FC7FFFF1819E410000000800000C07203C7FFFF1C39F210000000
      800001C07203C7FFFF1FFFF830000000C00003FFFFFFC7FFFF1FFFFFF0000000
      E00003FFFFFFC7FFFF1FFFFFF0000000F0000FFFFFFFC7FFFF1FFFFFF0000000
      F8001FFFFFFFC000001FFFFFF0000000FE003FFFFFFFC000001FFFFFF0000000
      FF81FFFFFFFFC000001FFFFFF000000000000000000000000000000000000000
      000000000000}
  end
end
