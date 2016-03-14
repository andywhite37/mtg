package mtg.core.model;

import haxe.ds.Option;
import thx.Error;

@:enum
abstract Symbol(String) to String {
  // Colorless
  var C = "{C}";
  var C0 = "{0}";
  var C1 = "{1}";
  var C2 = "{2}";
  var C3 = "{3}";
  var C4 = "{4}";
  var C5 = "{5}";
  var C6 = "{6}";
  var C7 = "{7}";
  var C8 = "{8}";
  var C9 = "{9}";
  var C10 = "{10}";
  var C11 = "{11}";
  var C12 = "{12}";
  var C13 = "{13}";
  var C14 = "{14}";
  var C15 = "{15}";
  var C16 = "{16}";
  var C17 = "{17}";
  var C18 = "{18}";
  var C19 = "{19}";
  var C20 = "{20}";
  var C100 = "{100}";
  var C1000000 = "{1000000}";
  var CHalf = "{1/2}";
  var CInfinity = "{Infinity}";

  // Single color
  var W = "{W}";
  var U = "{U}";
  var B = "{B}";
  var R = "{R}";
  var G = "{G}";

  // 1/2 color
  var WHalf = "{W 1/2}";
  var UHalf = "{U 1/2}";
  var BHalf = "{B 1/2}";
  var RHalf = "{R 1/2}";
  var GHalf = "{G 1/2}";

  // Phyrexian
  var P = "{P}";
  var WP = "{W/P}";
  var UP = "{U/P}";
  var BP = "{B/P}";
  var RP = "{R/P}";
  var GP = "{G/P}";

  // Split-colors
  var WU = "{W/U}";
  var WB = "{W/B}";
  var UB = "{U/B}";
  var UR = "{U/R}";
  var BR = "{B/R}";
  var BG = "{B/G}";
  var RG = "{R/G}";
  var RW = "{R/W}";
  var GW = "{G/W}";
  var GU = "{G/U}";

  // Split colorless and single
  var C2W = "{2/W}";
  var C2U = "{2/U}";
  var C2B = "{2/B}";
  var C2R = "{2/R}";
  var C2G = "{2/G}";

  // Snow
  var S = "{S}";

  // Variable
  var X = "{X}";
  var Y = "{Y}";
  var Z = "{Z}";

  // Tap/untap
  var Tap = "{T}";
  var Untap = "{Q}";

  public static function safeParse(input : String) : Option<Symbol> {
    return try {
      var symbol = parse(input);
      Some(symbol);
    } catch (e : Dynamic) {
      None;
    }
  }

  @:from public static function parse(input : String) : Symbol {
    return switch input {
      case "{C}": C;
      case "{0}": C0;
      case "{1}": C1;
      case "{2}": C2;
      case "{3}": C3;
      case "{4}": C4;
      case "{5}": C5;
      case "{6}": C6;
      case "{7}": C7;
      case "{8}": C8;
      case "{9}": C9;
      case "{10}": C10;
      case "{11}": C11;
      case "{12}": C12;
      case "{13}": C13;
      case "{14}": C14;
      case "{15}": C15;
      case "{16}": C16;
      case "{17}": C17;
      case "{18}": C18;
      case "{19}": C19;
      case "{20}": C20;
      case "{100}": C100;
      case "{1000000}": C1000000;
      case "{1/2}": CHalf;
      case "{Infinity}": CInfinity;

      // Single color
      case "{W}": W;
      case "{U}": U;
      case "{B}": B;
      case "{R}": R;
      case "{G}": G;

      // 1/2 color
      case "{W 1/2}": WHalf;
      case "{U 1/2}": UHalf;
      case "{B 1/2}": BHalf;
      case "{R 1/2}": RHalf;
      case "{G 1/2}": GHalf;

      // Phyrexian
      case "{P}": P;
      case "{W/P}": WP;
      case "{U/P}": UP;
      case "{B/P}": BP;
      case "{R/P}": RP;
      case "{G/P}": GP;

      // Split-colors
      case "{W/U}": WU;
      case "{W/B}": WB;
      case "{U/B}": UB;
      case "{U/R}": UR;
      case "{B/R}": BR;
      case "{B/G}": BG;
      case "{R/G}": RG;
      case "{R/W}": RW;
      case "{G/W}": GW;
      case "{G/U}": GU;

      // Split colorless and single
      case "{2/W}": C2W;
      case "{2/U}": C2U;
      case "{2/B}": C2B;
      case "{2/R}": C2R;
      case "{2/G}": C2G;

      // Snow
      case "{S}": S;

      // Variable
      case "{X}": X;
      case "{Y}": Y;
      case "{Z}": Z;

      // Tap/untap
      case "{T}": Tap;
      case "{Q}": Untap;

      case unsupported :
        trace('Unsupported symbol: $unsupported');
        throw new Error('Symbol $unsupported is not supported');
    }
  }
}
