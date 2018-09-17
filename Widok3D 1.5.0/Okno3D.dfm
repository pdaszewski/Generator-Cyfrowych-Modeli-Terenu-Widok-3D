object OpenGL: TOpenGL
  Left = 244
  Top = 159
  Caption = 'FX systems - Przestrzenny model terenu'
  ClientHeight = 491
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    615
    491)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 185
    Height = 41
    TabOrder = 0
    Visible = False
    object SpeedButton1: TSpeedButton
      Left = 120
      Top = 11
      Width = 41
      Height = 22
      Caption = 'OK'
      Flat = True
      OnClick = SpeedButton1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 24
      Top = 11
      Width = 49
      Height = 22
      MaxValue = 6
      MinValue = 1
      TabOrder = 0
      Value = 2
    end
  end
  object Panel2: TPanel
    Left = 395
    Top = 8
    Width = 209
    Height = 65
    Anchors = [akTop]
    TabOrder = 1
    Visible = False
    object Label1: TLabel
      Left = 9
      Top = 8
      Width = 139
      Height = 13
      Caption = 'Skalowanie            : +/-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 9
      Top = 24
      Width = 164
      Height = 13
      Caption = 'Przemieszczanie     : strza'#322'ki'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 9
      Top = 40
      Width = 164
      Height = 13
      Caption = 'Obracanie              : myszka'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object SpeedButton2: TSpeedButton
      Left = 184
      Top = 8
      Width = 15
      Height = 14
      Caption = 'X'
      Flat = True
      OnClick = SpeedButton2Click
    end
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 8
    Top = 456
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 192
    object Plik1: TMenuItem
      Caption = 'Plik'
      object Otwrzmapcyfrow1: TMenuItem
        Caption = 'Otw'#243'rz map'#281' cyfrow'#261
        OnClick = Otwrzmapcyfrow1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Zamknij1: TMenuItem
        Caption = 'Zamknij'
        OnClick = Zamknij1Click
      end
    end
    object Obiekty1: TMenuItem
      Caption = 'Obiekty'
      object Teren1: TMenuItem
        Caption = 'Teren'
        OnClick = Teren1Click
      end
      object Poziomzerowy1: TMenuItem
        Caption = 'Poziom zerowy'
        OnClick = Poziomzerowy1Click
      end
    end
    object Operacje1: TMenuItem
      Caption = 'Operacje'
      object Wyrnieniedepresji1: TMenuItem
        Caption = 'Wyr'#243#380'nienie depresji'
        OnClick = Wyrnieniedepresji1Click
      end
      object Wyrnieniedolin1: TMenuItem
        Caption = 'Wyr'#243#380'nienie dolin'
        OnClick = Wyrnieniedolin1Click
      end
      object Wyrnieniewyyn1: TMenuItem
        Caption = 'Wyr'#243#380'nienie wy'#380'yn'
        OnClick = Wyrnieniewyyn1Click
      end
      object Wyrnieniegr1: TMenuItem
        Caption = 'Wyr'#243#380'nienie g'#243'r'
        OnClick = Wyrnieniegr1Click
      end
    end
    object Animacja1: TMenuItem
      Caption = 'Animacja'
      object Obrtpoziomy1: TMenuItem
        Caption = 'Obr'#243't poziomy'
        OnClick = Obrtpoziomy1Click
      end
    end
    object Ustawienia1: TMenuItem
      Caption = 'Ustawienia'
      object Ustawowietlenie1: TMenuItem
        Caption = 'Ustaw o'#347'wietlenie'
        OnClick = Ustawowietlenie1Click
      end
      object Poziomprecyzji1: TMenuItem
        Caption = 'Poziom precyzji'
        OnClick = Poziomprecyzji1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Siatka1: TMenuItem
        Caption = 'Siatka'
        Checked = True
        OnClick = Siatka1Click
      end
      object Wypenienie1: TMenuItem
        Caption = 'Wype'#322'nienie'
        OnClick = Wypenienie1Click
      end
      object Kolorujteren1: TMenuItem
        Caption = 'Koloruj teren'
        OnClick = Kolorujteren1Click
      end
    end
    object Pomoc1: TMenuItem
      Caption = 'Pomoc'
      object Sterowanie1: TMenuItem
        Caption = 'Sterowanie widokiem'
        OnClick = Sterowanie1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Oprogramie1: TMenuItem
        Caption = 'O programie...'
        OnClick = Oprogramie1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.cgen'
    Filter = 'Plik map cyfrowych GEN (*.cgen)|*.cgen'
    Left = 176
    Top = 192
  end
  object Obrot: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ObrotTimer
    Left = 112
    Top = 192
  end
  object AutoRun: TTimer
    OnTimer = AutoRunTimer
    Left = 320
    Top = 192
  end
end
