package mtg.client.view;

import doom.html.Html.*;
import mtg.core.model.Symbol;

class SymbolView extends doom.html.Component<{ symbol : Symbol }> {
  override function render() {
    var fileName = switch props.symbol {
      case C: "C.svg";
      case C0: "0.svg";
      case C1: "1.svg";
      case C2: "2.svg";
      case C3: "3.svg";
      case C4: "4.svg";
      case C5: "5.svg";
      case C6: "6.svg";
      case C7: "7.svg";
      case C8: "8.svg";
      case C9: "9.svg";
      case C10: "10.svg";
      case C11: "11.svg";
      case C12: "12.svg";
      case C13: "13.svg";
      case C14: "14.svg";
      case C15: "15.svg";
      case C16: "16.svg";
      case C17: "17.svg";
      case C18: "18.svg";
      case C19: "19.svg";
      case C20: "20.svg";
      case C100: "100.svg";
      case C1000000: "1000000.svg";
      case CHalf: "half.svg";
      case CInfinity: "infinity.png";
      case W: "W.svg";
      case U: "U.svg";
      case B: "B.svg";
      case R: "R.svg";
      case G: "G.svg";
      case WHalf: "Whalf.svg";
      case UHalf: "Uhalf.svg";
      case BHalf: "Bhalf.svg";
      case RHalf: "Rhalf.svg";
      case GHalf: "Ghalf.svg";
      case P: "P.svg";
      case WP: "WP.svg";
      case UP: "UP.svg";
      case BP: "BP.svg";
      case RP: "RP.svg";
      case GP: "GP.svg";
      case WU: "WU.svg";
      case WB: "WB.svg";
      case UB: "UB.svg";
      case UR: "UR.svg";
      case BR: "BR.svg";
      case BG: "BG.svg";
      case RG: "RG.svg";
      case RW: "RW.svg";
      case GW: "GW.svg";
      case GU: "GU.svg";
      case C2W: "2W.svg";
      case C2U: "2U.svg";
      case C2B: "2B.svg";
      case C2R: "2R.svg";
      case C2G: "2G.svg";
      case S: "S.svg";
      case X: "X.svg";
      case Y: "Y.svg";
      case Z: "Z.svg";
      case Tap: "T.svg";
      case Untap: "Q.svg";
    };
    var src = '/assets/symbols/$fileName';
    var alt : String = props.symbol;
    return img(["class" => "symbol", "src" => src, "alt" => alt ]);
  }
}
