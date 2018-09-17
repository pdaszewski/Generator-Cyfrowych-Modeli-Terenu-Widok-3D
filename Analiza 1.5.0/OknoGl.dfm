object AGlowne: TAGlowne
  Left = 218
  Top = 117
  Caption = 'Analiza Cyfrowych Map'
  ClientHeight = 529
  ClientWidth = 767
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 662
    Top = 0
    Width = 105
    Height = 510
    Align = alRight
    AutoSize = True
    ExplicitLeft = 670
    ExplicitHeight = 520
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 510
    Width = 767
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object OpenCyfr: TOpenDialog
    DefaultExt = '*.cgen'
    Filter = 'Pliki map cyfrowych GEN (*.cgen)|*.cgen'
    Left = 40
    Top = 144
  end
  object MainMenu1: TMainMenu
    Left = 320
    Top = 216
    object Plik1: TMenuItem
      Caption = '&Plik'
      object Otwrzplikmapycyfrowej1: TMenuItem
        Caption = 'Otw'#243'rz plik mapy &cyfrowej'
        OnClick = Otwrzplikmapycyfrowej1Click
      end
      object Zapiszmapcyfrow1: TMenuItem
        Caption = 'Zapisz map'#281' cyfrow'#261
        OnClick = Zapiszmapcyfrow1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Exportmapykompresja1: TMenuItem
        Caption = 'Export do skompresowanej mapy'
        OnClick = Exportmapykompresja1Click
      end
      object Importskompresowanejmapy1: TMenuItem
        Caption = 'Import ze skompresowanej mapy'
        OnClick = Importskompresowanejmapy1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Zamknij1: TMenuItem
        Caption = '&Zamknij'
        OnClick = Zamknij1Click
      end
    end
    object Widok1: TMenuItem
      Caption = '&Widok'
      object Oknomapycyfrowej1: TMenuItem
        Caption = '&Okno mapy cyfrowej'
        OnClick = Oknomapycyfrowej1Click
      end
      object Wizualizacja3D1: TMenuItem
        Caption = 'Wizualizacja 3D'
        OnClick = Wizualizacja3D1Click
      end
    end
    object Operacje1: TMenuItem
      Caption = '&Operacje'
      object Statystykimapy1: TMenuItem
        Caption = 'Statystyki mapy'
        OnClick = Statystykimapy1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Mapawaciwa1: TMenuItem
        Caption = 'Mapa w'#322'a'#347'ciwa'
        OnClick = Mapawaciwa1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Zaznaczdepresje1: TMenuItem
        Caption = 'Zaznacz depresje'
        OnClick = Zaznaczdepresje1Click
      end
      object Zaznaczniziny1: TMenuItem
        Caption = 'Zaznacz niziny'
        OnClick = Zaznaczniziny1Click
      end
      object Zaznaczwyyny1: TMenuItem
        Caption = 'Zaznacz wy'#380'yny'
        OnClick = Zaznaczwyyny1Click
      end
      object Zaznaczgry1: TMenuItem
        Caption = 'Zaznacz g'#243'ry'
        OnClick = Zaznaczgry1Click
      end
      object Zaznaczwybrane1: TMenuItem
        Caption = 'Zaznacz wybrane'
        OnClick = Zaznaczwybrane1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Zaznacznajwyszyszczyt1: TMenuItem
        Caption = 'Zaznacz najwy'#380'szy szczyt'
        OnClick = Zaznacznajwyszyszczyt1Click
      end
      object Zaznacznajwikszgbin1: TMenuItem
        Caption = 'Zaznacz najwi'#281'ksz'#261' g'#322#281'bin'#281
        OnClick = Zaznacznajwikszgbin1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Obliczodlegoci1: TMenuItem
        Caption = 'Oblicz odleg'#322'o'#347'ci'
        OnClick = Obliczodlegoci1Click
      end
    end
    object Pomoc1: TMenuItem
      Caption = 'Pomoc'
      object Oprogramie1: TMenuItem
        Caption = 'O programie...'
        OnClick = Oprogramie1Click
      end
    end
  end
  object SaveCyfr: TSaveDialog
    DefaultExt = '*.cgen'
    Filter = 'Pliki map cyfrowych GEN (*.cgen)|*.cgen'
    Left = 80
    Top = 144
  end
  object SaveCyfK: TSaveDialog
    DefaultExt = '*.cgek'
    Filter = 'Skompresowane pliki map cyfrowych GEN (*.cgek)|*.cgek'
    Left = 72
    Top = 232
  end
  object OpenCyfrk: TOpenDialog
    DefaultExt = '*.cgek'
    Filter = 'Skompresowane pliki map cyfrowych GEN (*.cgek)|*.cgek'
    Left = 32
    Top = 232
  end
  object AutoRun: TTimer
    Interval = 500
    OnTimer = AutoRunTimer
    Left = 208
    Top = 248
  end
end
