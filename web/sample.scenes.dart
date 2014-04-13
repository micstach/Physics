library scene.samples ;

import 'physics/constraint.dart' ;
import 'physics/constraint.distance.dart' ;

import 'physics/particle.dart' ;
import 'physics/metabody1d.dart' ;
import 'physics/scene.dart' ;
import 'package:json/json.dart' as JSON;

void scene4(Scene scene)
{
  String jsonScene = '{"bodies":[{"type":"particle","position":{"x":157.0,"y":351.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":772854244},{"type":"particle","position":{"x":335.3121951219512,"y":389.20975609756096},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":580485577},{"type":"particle","position":{"x":353.3121951219512,"y":305.20975609756096},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":16188945},{"type":"particle","position":{"x":175.0,"y":267.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":357319461},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.10429914826427118,"hash-code":15003530},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.20322436119820336,"hash-code":813467470},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.3021495741321356,"hash-code":603889654},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.40107478706606775,"hash-code":137924348},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.5,"hash-code":473129000},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.5989252129339322,"hash-code":392823687},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.6978504258678645,"hash-code":1054386218},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.7967756388017966,"hash-code":1049326232},{"type":"metabody1d","a":772854244,"b":580485577,"f":0.8957008517357288,"hash-code":1051488542},{"type":"metabody1d","a":580485577,"b":16188945,"f":0.21230378697119726,"hash-code":622318021},{"type":"metabody1d","a":580485577,"b":16188945,"f":0.40410126232373245,"hash-code":59743269},{"type":"metabody1d","a":580485577,"b":16188945,"f":0.5958987376762676,"hash-code":760505735},{"type":"metabody1d","a":580485577,"b":16188945,"f":0.7876962130288028,"hash-code":695727863},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.10429914826427118,"hash-code":354437237},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.20322436119820336,"hash-code":535955252},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.3021495741321356,"hash-code":46352398},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.40107478706606775,"hash-code":792605288},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.5,"hash-code":769187390},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.5989252129339322,"hash-code":493686973},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.6978504258678645,"hash-code":598738151},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.7967756388017966,"hash-code":40141242},{"type":"metabody1d","a":16188945,"b":357319461,"f":0.8957008517357288,"hash-code":545486931},{"type":"metabody1d","a":357319461,"b":772854244,"f":0.21230378697119726,"hash-code":274246300},{"type":"metabody1d","a":357319461,"b":772854244,"f":0.40410126232373245,"hash-code":684255040},{"type":"metabody1d","a":357319461,"b":772854244,"f":0.5958987376762676,"hash-code":841263934},{"type":"metabody1d","a":357319461,"b":772854244,"f":0.7876962130288028,"hash-code":927109056},{"type":"particle","position":{"x":263.0,"y":223.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":17207863},{"type":"particle","position":{"x":433.9130566037736,"y":206.11969811320756},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":554412097},{"type":"particle","position":{"x":425.9130566037736,"y":125.11969811320756},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":192389962},{"type":"particle","position":{"x":255.0,"y":142.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":925070240},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.11344773596676172,"hash-code":750558827},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.22389123997625837,"hash-code":722959681},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.334334743985755,"hash-code":67851434},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.4447782479952517,"hash-code":80826198},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.5552217520047483,"hash-code":93555928},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.665665256014245,"hash-code":986810793},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.7761087600237416,"hash-code":881427160},{"type":"metabody1d","a":17207863,"b":554412097,"f":0.8865522640332383,"hash-code":964688757},{"type":"metabody1d","a":554412097,"b":192389962,"f":0.21714426752509267,"hash-code":1052009588},{"type":"metabody1d","a":554412097,"b":192389962,"f":0.4057147558416976,"hash-code":888188606},{"type":"metabody1d","a":554412097,"b":192389962,"f":0.5942852441583024,"hash-code":334908012},{"type":"metabody1d","a":554412097,"b":192389962,"f":0.7828557324749074,"hash-code":909559931},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.11344773596676172,"hash-code":1022751408},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.22389123997625837,"hash-code":224494180},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.334334743985755,"hash-code":361593247},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.4447782479952517,"hash-code":938406468},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.5552217520047483,"hash-code":253831736},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.665665256014245,"hash-code":121343964},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.7761087600237416,"hash-code":894960219},{"type":"metabody1d","a":192389962,"b":925070240,"f":0.8865522640332383,"hash-code":758835167},{"type":"metabody1d","a":925070240,"b":17207863,"f":0.21714426752509267,"hash-code":440318979},{"type":"metabody1d","a":925070240,"b":17207863,"f":0.4057147558416976,"hash-code":253207284},{"type":"metabody1d","a":925070240,"b":17207863,"f":0.5942852441583024,"hash-code":268640868},{"type":"metabody1d","a":925070240,"b":17207863,"f":0.7828557324749074,"hash-code":690795625},{"type":"particle","position":{"x":133.0,"y":65.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":120310172},{"type":"particle","position":{"x":226.12508087125298,"y":118.66530084106103},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":550955640},{"type":"particle","position":{"x":260.125080871253,"y":59.665300841061025},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":298628047},{"type":"particle","position":{"x":167.0,"y":6.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":1018580244},{"type":"metabody1d","a":120310172,"b":550955640,"f":0.1744315028227166,"hash-code":57599069},{"type":"metabody1d","a":120310172,"b":550955640,"f":0.3372157514113583,"hash-code":332720789},{"type":"metabody1d","a":120310172,"b":550955640,"f":0.5,"hash-code":743017498},{"type":"metabody1d","a":120310172,"b":550955640,"f":0.6627842485886417,"hash-code":820451357},{"type":"metabody1d","a":120310172,"b":550955640,"f":0.8255684971772834,"hash-code":642072157},{"type":"metabody1d","a":550955640,"b":298628047,"f":0.2645683576233669,"hash-code":702662643},{"type":"metabody1d","a":550955640,"b":298628047,"f":0.5,"hash-code":19123609},{"type":"metabody1d","a":550955640,"b":298628047,"f":0.7354316423766329,"hash-code":133027470},{"type":"metabody1d","a":298628047,"b":1018580244,"f":0.1744315028227166,"hash-code":879297853},{"type":"metabody1d","a":298628047,"b":1018580244,"f":0.3372157514113583,"hash-code":217170816},{"type":"metabody1d","a":298628047,"b":1018580244,"f":0.5,"hash-code":956235321},{"type":"metabody1d","a":298628047,"b":1018580244,"f":0.6627842485886417,"hash-code":198411003},{"type":"metabody1d","a":298628047,"b":1018580244,"f":0.8255684971772834,"hash-code":246565772},{"type":"metabody1d","a":1018580244,"b":120310172,"f":0.2645683576233669,"hash-code":640367891},{"type":"metabody1d","a":1018580244,"b":120310172,"f":0.5,"hash-code":436441647},{"type":"metabody1d","a":1018580244,"b":120310172,"f":0.7354316423766329,"hash-code":970105158},{"type":"particle","position":{"x":162.0,"y":204.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":1055014010},{"type":"particle","position":{"x":116.61806621354964,"y":116.16399912299934},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":949048369},{"type":"particle","position":{"x":56.61806621354964,"y":147.16399912299934},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":460573286},{"type":"particle","position":{"x":102.0,"y":235.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":795203719},{"type":"metabody1d","a":1055014010,"b":949048369,"f":0.2008594908113062,"hash-code":853982748},{"type":"metabody1d","a":1055014010,"b":949048369,"f":0.40028649693710205,"hash-code":949722972},{"type":"metabody1d","a":1055014010,"b":949048369,"f":0.599713503062898,"hash-code":204889518},{"type":"metabody1d","a":1055014010,"b":949048369,"f":0.7991405091886938,"hash-code":122503673},{"type":"metabody1d","a":949048369,"b":460573286,"f":0.265380656317492,"hash-code":414278971},{"type":"metabody1d","a":949048369,"b":460573286,"f":0.5,"hash-code":226344458},{"type":"metabody1d","a":949048369,"b":460573286,"f":0.7346193436825079,"hash-code":186705764},{"type":"metabody1d","a":460573286,"b":795203719,"f":0.2008594908113062,"hash-code":580678843},{"type":"metabody1d","a":460573286,"b":795203719,"f":0.40028649693710205,"hash-code":789927221},{"type":"metabody1d","a":460573286,"b":795203719,"f":0.599713503062898,"hash-code":252432722},{"type":"metabody1d","a":460573286,"b":795203719,"f":0.7991405091886938,"hash-code":561866996},{"type":"metabody1d","a":795203719,"b":1055014010,"f":0.265380656317492,"hash-code":570184232},{"type":"metabody1d","a":795203719,"b":1055014010,"f":0.5,"hash-code":233210464},{"type":"metabody1d","a":795203719,"b":1055014010,"f":0.7346193436825079,"hash-code":788092754},{"type":"particle","position":{"x":77.0,"y":453.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":392842800},{"type":"particle","position":{"x":332.2205408886027,"y":494.76336123631677},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":111525324},{"type":"particle","position":{"x":341.2205408886027,"y":439.76336123631677},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":34270475},{"type":"particle","position":{"x":86.0,"y":398.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":765054917},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.0771118949846251,"hash-code":880495660},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.1540006413510569,"hash-code":50531054},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.23088938771748868,"hash-code":620954068},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.3077781340839205,"hash-code":383854490},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.3846668804503523,"hash-code":611459518},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.4615556268167841,"hash-code":891138003},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.5384443731832159,"hash-code":479745670},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.6153331195496476,"hash-code":771652091},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.6922218659160795,"hash-code":65612854},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.7691106122825112,"hash-code":214441184},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.845999358648943,"hash-code":661838979},{"type":"metabody1d","a":392842800,"b":111525324,"f":0.9228881050153748,"hash-code":848438226},{"type":"metabody1d","a":111525324,"b":34270475,"f":0.33971587117252267,"hash-code":528558713},{"type":"metabody1d","a":111525324,"b":34270475,"f":0.6602841288274773,"hash-code":909451781},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.0771118949846251,"hash-code":110505862},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.1540006413510569,"hash-code":705637996},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.23088938771748868,"hash-code":896704835},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.3077781340839205,"hash-code":646858553},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.3846668804503523,"hash-code":852036914},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.4615556268167841,"hash-code":214357377},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.5384443731832159,"hash-code":107922844},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.6153331195496476,"hash-code":191527149},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.6922218659160795,"hash-code":198404215},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.7691106122825112,"hash-code":620973959},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.845999358648943,"hash-code":340164321},{"type":"metabody1d","a":34270475,"b":765054917,"f":0.9228881050153748,"hash-code":484697224},{"type":"metabody1d","a":765054917,"b":392842800,"f":0.33971587117252267,"hash-code":850649966},{"type":"metabody1d","a":765054917,"b":392842800,"f":0.6602841288274773,"hash-code":524983487},{"type":"particle","position":{"x":267.0,"y":573.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":984926755},{"type":"particle","position":{"x":575.4909726266744,"y":527.8549796156086},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":130678121},{"type":"particle","position":{"x":569.4909726266744,"y":486.8549796156086},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":849354108},{"type":"particle","position":{"x":261.0,"y":532.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":840220736},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.06326928203642276,"hash-code":401824635},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.1256593846026481,"hash-code":632685640},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.1880494871688734,"hash-code":491273687},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.2504395897350988,"hash-code":82281268},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.31282969230132407,"hash-code":461841774},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.37521979486754936,"hash-code":596532522},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.4376098974337747,"hash-code":849621580},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.5,"hash-code":877532500},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.5623901025662253,"hash-code":756004063},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.6247802051324506,"hash-code":845703508},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.6871703076986759,"hash-code":117249452},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.7495604102649012,"hash-code":118881608},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.8119505128311265,"hash-code":851003934},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.8743406153973518,"hash-code":1045074996},{"type":"metabody1d","a":984926755,"b":130678121,"f":0.9367307179635772,"hash-code":989573725},{"type":"metabody1d","a":130678121,"b":849354108,"f":0.3706659834309881,"hash-code":992949778},{"type":"metabody1d","a":130678121,"b":849354108,"f":0.6293340165690119,"hash-code":634941725},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.06326928203642276,"hash-code":828881756},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.1256593846026481,"hash-code":945202482},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.1880494871688734,"hash-code":766959628},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.2504395897350988,"hash-code":627030390},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.31282969230132407,"hash-code":561285178},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.37521979486754936,"hash-code":105814459},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.4376098974337747,"hash-code":443217859},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.5,"hash-code":672101601},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.5623901025662253,"hash-code":1022149715},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.6247802051324506,"hash-code":413237361},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.6871703076986759,"hash-code":420320968},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.7495604102649012,"hash-code":308667699},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.8119505128311265,"hash-code":832821612},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.8743406153973518,"hash-code":255139891},{"type":"metabody1d","a":849354108,"b":840220736,"f":0.9367307179635772,"hash-code":301818020},{"type":"metabody1d","a":840220736,"b":984926755,"f":0.3706659834309881,"hash-code":64899044},{"type":"metabody1d","a":840220736,"b":984926755,"f":0.6293340165690119,"hash-code":176863740},{"type":"particle","position":{"x":401.0,"y":444.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":718491239},{"type":"particle","position":{"x":584.626198083067,"y":436.6549520766773},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":653796214},{"type":"particle","position":{"x":577.626198083067,"y":261.6549520766773},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":429203714},{"type":"particle","position":{"x":394.0,"y":269.0},"velocity":{"x":0.0,"y":0.0},"radius":10.0,"mass-inv":1.0,"hash-code":898845206},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.10392439612661275,"hash-code":157601630},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.20294329709495956,"hash-code":234737157},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.3019621980633064,"hash-code":704316331},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.40098109903165313,"hash-code":864996802},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.5,"hash-code":9182873},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.5990189009683468,"hash-code":471567344},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.6980378019366936,"hash-code":272003493},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.7970567029050404,"hash-code":735968540},{"type":"metabody1d","a":718491239,"b":653796214,"f":0.8960756038733872,"hash-code":1002508968},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.11246004793608946,"hash-code":658572674},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.22318574852577822,"hash-code":882030571},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.3339114491154669,"hash-code":193709153},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.44463714970515567,"hash-code":358721930},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.5553628502948444,"hash-code":643983297},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.6660885508845331,"hash-code":88355920},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.7768142514742217,"hash-code":91640941},{"type":"metabody1d","a":653796214,"b":429203714,"f":0.8875399520639105,"hash-code":110225055},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.10392439612661275,"hash-code":444792744},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.20294329709495956,"hash-code":541185104},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.3019621980633064,"hash-code":233864003},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.40098109903165313,"hash-code":907317750},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.5,"hash-code":1041318764},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.5990189009683468,"hash-code":714930975},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.6980378019366936,"hash-code":373664469},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.7970567029050404,"hash-code":61278250},{"type":"metabody1d","a":429203714,"b":898845206,"f":0.8960756038733872,"hash-code":760841081},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.11246004793608946,"hash-code":688770986},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.22318574852577822,"hash-code":784461881},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.3339114491154669,"hash-code":383864786},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.44463714970515567,"hash-code":675798965},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.5553628502948444,"hash-code":786969099},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.6660885508845331,"hash-code":919940596},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.7768142514742217,"hash-code":282872266},{"type":"metabody1d","a":898845206,"b":718491239,"f":0.8875399520639105,"hash-code":660144952}],"constraints":[{"type":"distance","a":772854244,"b":580485577},{"type":"distance","a":580485577,"b":16188945},{"type":"distance","a":16188945,"b":357319461},{"type":"distance","a":357319461,"b":772854244},{"type":"distance","a":772854244,"b":16188945},{"type":"distance","a":580485577,"b":357319461},{"type":"distance","a":17207863,"b":554412097},{"type":"distance","a":554412097,"b":192389962},{"type":"distance","a":192389962,"b":925070240},{"type":"distance","a":925070240,"b":17207863},{"type":"distance","a":17207863,"b":192389962},{"type":"distance","a":554412097,"b":925070240},{"type":"distance","a":120310172,"b":550955640},{"type":"distance","a":550955640,"b":298628047},{"type":"distance","a":298628047,"b":1018580244},{"type":"distance","a":1018580244,"b":120310172},{"type":"distance","a":120310172,"b":298628047},{"type":"distance","a":550955640,"b":1018580244},{"type":"distance","a":1055014010,"b":949048369},{"type":"distance","a":949048369,"b":460573286},{"type":"distance","a":460573286,"b":795203719},{"type":"distance","a":795203719,"b":1055014010},{"type":"distance","a":1055014010,"b":460573286},{"type":"distance","a":949048369,"b":795203719},{"type":"distance","a":392842800,"b":111525324},{"type":"distance","a":111525324,"b":34270475},{"type":"distance","a":34270475,"b":765054917},{"type":"distance","a":765054917,"b":392842800},{"type":"distance","a":392842800,"b":34270475},{"type":"distance","a":111525324,"b":765054917},{"type":"distance","a":984926755,"b":130678121},{"type":"distance","a":130678121,"b":849354108},{"type":"distance","a":849354108,"b":840220736},{"type":"distance","a":840220736,"b":984926755},{"type":"distance","a":984926755,"b":849354108},{"type":"distance","a":130678121,"b":840220736},{"type":"distance","a":718491239,"b":653796214},{"type":"distance","a":653796214,"b":429203714},{"type":"distance","a":429203714,"b":898845206},{"type":"distance","a":898845206,"b":718491239},{"type":"distance","a":718491239,"b":429203714},{"type":"distance","a":653796214,"b":898845206}]}' ;

  scene.readJSON(JSON.parse(jsonScene)) ;
}

void scene3(List<Particle> particles, List<Constraint> constraints)
{
  particles.clear() ;
  constraints.clear() ;
  
  double x = 400.0 ; 
  double y = 500.0 ; 

  Particle p1 = new Particle(x, y) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
  p1 = new Particle(x, y-200) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;
}

void scene2(List<Particle> particles, List<Constraint> constraints)
{
  particles.clear() ;
  constraints.clear() ;

  double x = 400.0 ; 
  double y = 500.0 ; 

  Particle p1 = new Particle(x-50, y+30) ;
  p1.Mass = 1.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  p1 = new Particle(x-120, y+20) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  p1 = new Particle(x+20, y+20) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

  p1 = new Particle(x, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  Particle p2 = new Particle(x+100, y) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;
  
  p1 = new Particle(x-20, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-20, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-40, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-40, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-60, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-60, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-80, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;

//  p2 = new Particle(x-80, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//
//  constraints.add(new Distance(p1, p2)) ;

  p1 = new Particle(x-100, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
//  p2 = new Particle(x-100, y-100) ;
//  p2.Mass = 5.0 ;
//  p2.Velocity.Zero();
//  particles.add(p2) ;
//  
//  constraints.add(new Distance(p1, p2)) ;
}

void scene1(List<Particle> particles, List<Constraint> constraints)
{
  particles.clear() ;
  constraints.clear() ;
  
  double s = 15.0 ;
  double x = 400.0 ; 
  double y = 500.0 ; 
  int count = 25 ;

  Particle p1 = new Particle(x, y) ;
  p1.Mass = double.INFINITY ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
  Particle p0 = p1 ;
  
  for (int i=1; i<=count; i++)
  {
    Particle p2 = new Particle(x + i * s, y, 5.0 + (i*2.0)/count) ;
    p2.Mass = 1.0 + i * 0.25 ; //(i==count) ? 100.0 : 1.0 ;
      
    p2.Velocity.Zero();
    particles.add(p2) ;
  
    constraints.add(new ConstraintDistance(p1, p2)) ;
    p1 = p2 ;
  }
  
  p1 = new Particle(30.0, 30.0, 15.0) ;
  p1.Mass = 5.0 ;
  p1.Velocity.Zero();
  particles.add(p1) ;
  
  var p2 = new Particle(70.0, 30.0, 15.0) ;
  p2.Mass = 5.0 ;
  p2.Velocity.Zero();
  particles.add(p2) ;
  
  var p3 = new Particle(70.0, 70.0) ;
  p3.Mass = 5.0 ;
  p3.Velocity.Zero();
  particles.add(p3) ;

  var p4 = new Particle(30.0, 70.0) ;
  p4.Mass = 5.0 ;
  p4.Velocity.Zero();
  particles.add(p4) ;
  
  constraints.add(new ConstraintDistance(p1, p2)) ;
  constraints.add(new ConstraintDistance(p2, p3)) ;
  constraints.add(new ConstraintDistance(p3, p4)) ;
  constraints.add(new ConstraintDistance(p4, p1)) ;
  constraints.add(new ConstraintDistance(p1, p3)) ;
  constraints.add(new ConstraintDistance(p2, p4)) ;
}
