package mtg.core.model;

@:enum
abstract ManaSymbol(String) from String to String {
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
  var WP = "{WP}";
  var UP = "{UP}";
  var BP = "{BP}";
  var RP = "{RP}";
  var GP = "{GP}";

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
}
