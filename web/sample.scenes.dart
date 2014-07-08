library scene.samples ;

import 'physics/constraint.dart' ;
import 'physics/constraint.distance.dart' ;

import 'physics/particle.dart' ;
import 'physics/scene.dart' ;
import 'package:json/json.dart' as JSON;

void scene4(Scene scene)
{
  String jsonScene = '{"bodies":[{"type":"particle","position":{"x":177.01200555432288,"y":116.59931342368104},"velocity":{"x":0.027075259800037194,"y":-0.0026681609925665074},"radius":10,"mass-inv":1,"hash-code":280851693,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":275.91239845158634,"y":116.00388763059165},"velocity":{"x":0.027109012450837952,"y":0.002837229139443941},"radius":10,"mass-inv":1,"hash-code":630578145,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":275.26964808454017,"y":10},"velocity":{"x":0.033048653017857726,"y":0.17564214954586688},"radius":10,"mass-inv":1,"hash-code":178817394,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":176.36860930290365,"y":10},"velocity":{"x":0.0330221924742065,"y":0.05696835015208618},"radius":10,"mass-inv":1,"hash-code":265510885,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":280851693,"b":630578145,"f":0.20083247150748618,"hash-code":415511157,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":280851693,"b":630578145,"f":0.4002774905024954,"hash-code":44934243,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":280851693,"b":630578145,"f":0.5997225094975046,"hash-code":690309498,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":280851693,"b":630578145,"f":0.7991675284925139,"hash-code":748447737,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":630578145,"b":178817394,"f":0.17476309016255964,"hash-code":141373181,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":630578145,"b":178817394,"f":0.3373815450812799,"hash-code":951930987,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":630578145,"b":178817394,"f":0.5,"hash-code":1053735655,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":630578145,"b":178817394,"f":0.6626184549187203,"hash-code":563114602,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":630578145,"b":178817394,"f":0.8252369098374404,"hash-code":183191377,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":178817394,"b":265510885,"f":0.20083247150748618,"hash-code":725564690,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":178817394,"b":265510885,"f":0.4002774905024954,"hash-code":518677765,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":178817394,"b":265510885,"f":0.5997225094975046,"hash-code":982586883,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":178817394,"b":265510885,"f":0.7991675284925139,"hash-code":814718085,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":265510885,"b":280851693,"f":0.17476309016255964,"hash-code":53726127,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":265510885,"b":280851693,"f":0.3373815450812799,"hash-code":510008135,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":265510885,"b":280851693,"f":0.5,"hash-code":260746987,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":265510885,"b":280851693,"f":0.6626184549187203,"hash-code":359948768,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":265510885,"b":280851693,"f":0.8252369098374404,"hash-code":589399947,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":208.54209881880863,"y":271.9307168158727},"velocity":{"x":0.005069374617402523,"y":-0.0041330510675913704},"radius":10,"mass-inv":1,"hash-code":539814791,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":267.37310510884146,"y":271.31095924507923},"velocity":{"x":0.0051584369542399125,"y":0.004271297972057607},"radius":10,"mass-inv":1,"hash-code":603996963,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":265.9193517910181,"y":133.3041046101794},"velocity":{"x":0.02487410786904831,"y":0.004062427961295376},"radius":10,"mass-inv":1,"hash-code":1053876817,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":207.0882091657355,"y":133.9238488911836},"velocity":{"x":0.024785220779328626,"y":-0.004342525565477701},"radius":10,"mass-inv":1,"hash-code":1013087643,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":539814791,"b":603996963,"f":0.3349842930989464,"hash-code":847108183,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":539814791,"b":603996963,"f":0.6650157069010536,"hash-code":314295026,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":603996963,"b":1053876817,"f":0.14371346597748189,"hash-code":964155264,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":603996963,"b":1053876817,"f":0.2862280795864891,"hash-code":30995858,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":603996963,"b":1053876817,"f":0.4287426931954964,"hash-code":543618700,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":603996963,"b":1053876817,"f":0.5712573068045036,"hash-code":112365069,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":603996963,"b":1053876817,"f":0.7137719204135109,"hash-code":338393678,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":603996963,"b":1053876817,"f":0.8562865340225182,"hash-code":620840557,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1053876817,"b":1013087643,"f":0.3349842930989464,"hash-code":601418806,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1053876817,"b":1013087643,"f":0.6650157069010536,"hash-code":1018304046,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1013087643,"b":539814791,"f":0.14371346597748189,"hash-code":661687942,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1013087643,"b":539814791,"f":0.2862280795864891,"hash-code":906808775,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1013087643,"b":539814791,"f":0.4287426931954964,"hash-code":252959624,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1013087643,"b":539814791,"f":0.5712573068045036,"hash-code":1070455490,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1013087643,"b":539814791,"f":0.7137719204135109,"hash-code":23722370,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":1013087643,"b":539814791,"f":0.8562865340225182,"hash-code":790369746,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":121.47965527717685,"y":362.578658528189},"velocity":{"x":-0.008730463033821715,"y":-0.017085794546530836},"radius":10,"mass-inv":1,"hash-code":503368752,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":376.41712506018774,"y":359.0767205605755},"velocity":{"x":-0.00820706994908766,"y":0.020808638153801833},"radius":10,"mass-inv":1,"hash-code":548108366,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":375.4280983062932,"y":287.076568986693},"velocity":{"x":0.002495135395057179,"y":0.02066081419152175},"radius":10,"mass-inv":1,"hash-code":671148844,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":120.49062812737513,"y":290.5785059141817},"velocity":{"x":0.0019718361736944584,"y":-0.0172336263353691},"radius":10,"mass-inv":1,"hash-code":648324407,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.07761980432872917,"hash-code":251379821,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.15441620354168747,"hash-code":174732750,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.23121260275464584,"hash-code":475502037,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.30800900196760417,"hash-code":76467973,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.3848054011805625,"hash-code":423489964,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.46160180039352083,"hash-code":837498989,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.5383981996064792,"hash-code":504661309,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.6151945988194374,"hash-code":590316072,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.6919909980323957,"hash-code":165852613,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.768787397245354,"hash-code":438447981,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.8455837964583124,"hash-code":396594776,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":503368752,"b":548108366,"f":0.9223801956712708,"hash-code":347917633,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":548108366,"b":671148844,"f":0.25925032993838476,"hash-code":995900483,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":548108366,"b":671148844,"f":0.5,"hash-code":128197496,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":548108366,"b":671148844,"f":0.7407496700616152,"hash-code":833690244,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.07761980432872917,"hash-code":758280413,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.15441620354168747,"hash-code":497360413,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.23121260275464584,"hash-code":186595833,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.30800900196760417,"hash-code":402852920,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.3848054011805625,"hash-code":826076127,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.46160180039352083,"hash-code":133598713,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.5383981996064792,"hash-code":799082490,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.6151945988194374,"hash-code":892945928,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.6919909980323957,"hash-code":414766693,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.768787397245354,"hash-code":706213719,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.8455837964583124,"hash-code":270827450,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":671148844,"b":648324407,"f":0.9223801956712708,"hash-code":926476981,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":648324407,"b":503368752,"f":0.25925032993838476,"hash-code":775999692,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":648324407,"b":503368752,"f":0.5,"hash-code":187585633,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":648324407,"b":503368752,"f":0.7407496700616152,"hash-code":489415057,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":152.40156320191977,"y":454.9746494595069},"velocity":{"x":0.04543134944220915,"y":0.00311978956924609},"radius":10,"mass-inv":1,"hash-code":779490280,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":227.4011029842068,"y":454.7123570785539},"velocity":{"x":0.04535017672349531,"y":-0.02117776183100136},"radius":10,"mass-inv":1,"hash-code":362988615,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":227.13881321103383,"y":379.71281676141757},"velocity":{"x":0.021052785189373525,"y":-0.02109669789097502},"radius":10,"mass-inv":1,"hash-code":585050280,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":152.13927173757577,"y":379.97510560779375},"velocity":{"x":0.021133660574718157,"y":0.0032008303462307316},"radius":10,"mass-inv":1,"hash-code":361194452,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":779490280,"b":362988615,"f":0.25555555555555554,"hash-code":884505958,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":779490280,"b":362988615,"f":0.5,"hash-code":428929909,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":779490280,"b":362988615,"f":0.7444444444444444,"hash-code":600561107,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":362988615,"b":585050280,"f":0.25555555555555554,"hash-code":429168943,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":362988615,"b":585050280,"f":0.5,"hash-code":717208805,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":362988615,"b":585050280,"f":0.7444444444444444,"hash-code":372329636,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":585050280,"b":361194452,"f":0.25555555555555554,"hash-code":492078625,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":585050280,"b":361194452,"f":0.5,"hash-code":313820921,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":585050280,"b":361194452,"f":0.7444444444444444,"hash-code":772947966,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":361194452,"b":779490280,"f":0.25555555555555554,"hash-code":940129209,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":361194452,"b":779490280,"f":0.5,"hash-code":121728946,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":361194452,"b":779490280,"f":0.7444444444444444,"hash-code":672733671,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":274.2275173176495,"y":454.7766771452381},"velocity":{"x":-0.053693614055648625,"y":0.000284802196496136},"radius":10,"mass-inv":1,"hash-code":661124056,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":374.225531855964,"y":454.14699808027484},"velocity":{"x":-0.05353254013259306,"y":0.025348837755601455},"radius":10,"mass-inv":1,"hash-code":898074731,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":373.75327504361445,"y":379.14848432620727},"velocity":{"x":-0.034734627572417104,"y":0.025228102035354968},"radius":10,"mass-inv":1,"hash-code":668218789,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":273.7552560788353,"y":379.7781626364701},"velocity":{"x":-0.034895446372561575,"y":0.00016403088773899854},"radius":10,"mass-inv":1,"hash-code":843104699,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":661124056,"b":898074731,"f":0.18,"hash-code":182686815,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":661124056,"b":898074731,"f":0.34,"hash-code":112635915,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":661124056,"b":898074731,"f":0.5,"hash-code":732945486,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":661124056,"b":898074731,"f":0.66,"hash-code":230092725,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":661124056,"b":898074731,"f":0.82,"hash-code":766320003,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":898074731,"b":668218789,"f":0.25555555555555554,"hash-code":224392717,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":898074731,"b":668218789,"f":0.5,"hash-code":742668361,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":898074731,"b":668218789,"f":0.7444444444444444,"hash-code":629052631,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":668218789,"b":843104699,"f":0.18,"hash-code":382076990,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":668218789,"b":843104699,"f":0.34,"hash-code":360338788,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":668218789,"b":843104699,"f":0.5,"hash-code":292279006,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":668218789,"b":843104699,"f":0.66,"hash-code":34666888,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":668218789,"b":843104699,"f":0.82,"hash-code":846481286,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":843104699,"b":661124056,"f":0.25555555555555554,"hash-code":476023533,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":843104699,"b":661124056,"f":0.5,"hash-code":180410280,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":843104699,"b":661124056,"f":0.7444444444444444,"hash-code":271722080,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":216.62614998965216,"y":548.147662172671},"velocity":{"x":-0.02284990699857715,"y":0.017405454426186934},"radius":10,"mass-inv":1,"hash-code":349503485,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":316.62539209413853,"y":548.5370532369286},"velocity":{"x":-0.02276303709027277,"y":-0.004299582545299984},"radius":10,"mass-inv":1,"hash-code":715303500,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":316.9174350219114,"y":473.5376216514507},"velocity":{"x":-0.03904180821620821,"y":-0.0043647339863274555},"radius":10,"mass-inv":1,"hash-code":1054954977,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":216.91819360967622,"y":473.1482306543996},"velocity":{"x":-0.03912868804031781,"y":0.017340298437832274},"radius":10,"mass-inv":1,"hash-code":402412968,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":349503485,"b":715303500,"f":0.18,"hash-code":500998851,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":349503485,"b":715303500,"f":0.34,"hash-code":1052542566,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":349503485,"b":715303500,"f":0.5,"hash-code":356510735,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":349503485,"b":715303500,"f":0.66,"hash-code":216396306,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":349503485,"b":715303500,"f":0.82,"hash-code":557484656,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":715303500,"b":1054954977,"f":0.25555555555555554,"hash-code":339941553,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":715303500,"b":1054954977,"f":0.5,"hash-code":195488512,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":715303500,"b":1054954977,"f":0.7444444444444444,"hash-code":789910791,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":1054954977,"b":402412968,"f":0.18,"hash-code":758415549,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":1054954977,"b":402412968,"f":0.34,"hash-code":1032134116,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":1054954977,"b":402412968,"f":0.5,"hash-code":1056948134,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":1054954977,"b":402412968,"f":0.66,"hash-code":209099868,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":1054954977,"b":402412968,"f":0.82,"hash-code":670525885,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":402412968,"b":349503485,"f":0.25555555555555554,"hash-code":988345094,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":402412968,"b":349503485,"f":0.5,"hash-code":714432953,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":402412968,"b":349503485,"f":0.7444444444444444,"hash-code":398077432,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"}],"constraints":[{"type":"distance","a":280851693,"b":630578145},{"type":"distance","a":630578145,"b":178817394},{"type":"distance","a":178817394,"b":265510885},{"type":"distance","a":265510885,"b":280851693},{"type":"distance","a":280851693,"b":178817394},{"type":"distance","a":630578145,"b":265510885},{"type":"distance","a":539814791,"b":603996963},{"type":"distance","a":603996963,"b":1053876817},{"type":"distance","a":1053876817,"b":1013087643},{"type":"distance","a":1013087643,"b":539814791},{"type":"distance","a":539814791,"b":1053876817},{"type":"distance","a":603996963,"b":1013087643},{"type":"distance","a":503368752,"b":548108366},{"type":"distance","a":548108366,"b":671148844},{"type":"distance","a":671148844,"b":648324407},{"type":"distance","a":648324407,"b":503368752},{"type":"distance","a":503368752,"b":671148844},{"type":"distance","a":548108366,"b":648324407},{"type":"distance","a":779490280,"b":362988615},{"type":"distance","a":362988615,"b":585050280},{"type":"distance","a":585050280,"b":361194452},{"type":"distance","a":361194452,"b":779490280},{"type":"distance","a":779490280,"b":585050280},{"type":"distance","a":362988615,"b":361194452},{"type":"distance","a":661124056,"b":898074731},{"type":"distance","a":898074731,"b":668218789},{"type":"distance","a":668218789,"b":843104699},{"type":"distance","a":843104699,"b":661124056},{"type":"distance","a":661124056,"b":668218789},{"type":"distance","a":898074731,"b":843104699},{"type":"distance","a":349503485,"b":715303500},{"type":"distance","a":715303500,"b":1054954977},{"type":"distance","a":1054954977,"b":402412968},{"type":"distance","a":402412968,"b":349503485},{"type":"distance","a":349503485,"b":1054954977},{"type":"distance","a":715303500,"b":402412968}]}' ;

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
