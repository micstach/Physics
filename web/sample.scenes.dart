library scene.samples ;

import 'physics/constraint.dart' ;
import 'physics/constraint.distance.dart' ;

import 'physics/particle.dart' ;
import 'physics/scene.dart' ;
import 'package:json/json.dart' as JSON;

void scene4(Scene scene)
{
  String jsonScene = '{"bodies":[{"type":"particle","position":{"x":177.01200555432288,"y":116.59931342368104},"velocity":{"x":0.027075259800037194,"y":-0.0026681609925665074},"radius":10,"mass-inv":1,"hash-code":509015514,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":275.91239845158634,"y":116.00388763059165},"velocity":{"x":0.027109012450837952,"y":0.002837229139443941},"radius":10,"mass-inv":1,"hash-code":417388204,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":275.26964808454017,"y":10},"velocity":{"x":0.033048653017857726,"y":0.17564214954586688},"radius":10,"mass-inv":1,"hash-code":182352726,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":176.36860930290365,"y":10},"velocity":{"x":0.0330221924742065,"y":0.05696835015208618},"radius":10,"mass-inv":1,"hash-code":149301034,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":509015514,"b":417388204,"f":0.20083247150748618,"hash-code":741211648,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":509015514,"b":417388204,"f":0.4002774905024954,"hash-code":806411444,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":509015514,"b":417388204,"f":0.5997225094975046,"hash-code":669647211,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":509015514,"b":417388204,"f":0.7991675284925139,"hash-code":319865187,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":417388204,"b":182352726,"f":0.17476309016255964,"hash-code":700051126,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":417388204,"b":182352726,"f":0.3373815450812799,"hash-code":418552279,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":417388204,"b":182352726,"f":0.5,"hash-code":17099709,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":417388204,"b":182352726,"f":0.6626184549187203,"hash-code":989960012,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":417388204,"b":182352726,"f":0.8252369098374404,"hash-code":106568539,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":182352726,"b":149301034,"f":0.20083247150748618,"hash-code":781050310,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":182352726,"b":149301034,"f":0.4002774905024954,"hash-code":901461490,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":182352726,"b":149301034,"f":0.5997225094975046,"hash-code":97905644,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":182352726,"b":149301034,"f":0.7991675284925139,"hash-code":221852323,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":149301034,"b":509015514,"f":0.17476309016255964,"hash-code":322543114,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":149301034,"b":509015514,"f":0.3373815450812799,"hash-code":1056523053,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":149301034,"b":509015514,"f":0.5,"hash-code":42820330,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":149301034,"b":509015514,"f":0.6626184549187203,"hash-code":903103533,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"metabody1d","a":149301034,"b":509015514,"f":0.8252369098374404,"hash-code":65162922,"group-name":"38bf8860-b420-11e3-8d10-01ef3ce106b7"},{"type":"particle","position":{"x":208.54209881880863,"y":271.9307168158727},"velocity":{"x":0.005069374617402523,"y":-0.0041330510675913704},"radius":10,"mass-inv":1,"hash-code":125604452,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":267.37310510884146,"y":271.31095924507923},"velocity":{"x":0.0051584369542399125,"y":0.004271297972057607},"radius":10,"mass-inv":1,"hash-code":516021118,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":265.9193517910181,"y":133.3041046101794},"velocity":{"x":0.02487410786904831,"y":0.004062427961295376},"radius":10,"mass-inv":1,"hash-code":633354561,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":207.0882091657355,"y":133.9238488911836},"velocity":{"x":0.024785220779328626,"y":-0.004342525565477701},"radius":10,"mass-inv":1,"hash-code":374567880,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":125604452,"b":516021118,"f":0.3349842930989464,"hash-code":382847395,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":125604452,"b":516021118,"f":0.6650157069010536,"hash-code":401819973,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":516021118,"b":633354561,"f":0.14371346597748189,"hash-code":273157899,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":516021118,"b":633354561,"f":0.2862280795864891,"hash-code":703958284,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":516021118,"b":633354561,"f":0.4287426931954964,"hash-code":17796791,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":516021118,"b":633354561,"f":0.5712573068045036,"hash-code":1058179231,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":516021118,"b":633354561,"f":0.7137719204135109,"hash-code":130945517,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":516021118,"b":633354561,"f":0.8562865340225182,"hash-code":681841452,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":633354561,"b":374567880,"f":0.3349842930989464,"hash-code":609293174,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":633354561,"b":374567880,"f":0.6650157069010536,"hash-code":84278996,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":374567880,"b":125604452,"f":0.14371346597748189,"hash-code":160307235,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":374567880,"b":125604452,"f":0.2862280795864891,"hash-code":36995584,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":374567880,"b":125604452,"f":0.4287426931954964,"hash-code":672041964,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":374567880,"b":125604452,"f":0.5712573068045036,"hash-code":865849659,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":374567880,"b":125604452,"f":0.7137719204135109,"hash-code":191813717,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"metabody1d","a":374567880,"b":125604452,"f":0.8562865340225182,"hash-code":446342398,"group-name":"3ac1e810-b420-11e3-ef29-5bc61739593c"},{"type":"particle","position":{"x":121.47965527717685,"y":362.578658528189},"velocity":{"x":-0.008730463033821715,"y":-0.017085794546530836},"radius":10,"mass-inv":1,"hash-code":825919030,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":376.41712506018774,"y":359.0767205605755},"velocity":{"x":-0.00820706994908766,"y":0.020808638153801833},"radius":10,"mass-inv":1,"hash-code":672485740,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":375.4280983062932,"y":287.076568986693},"velocity":{"x":0.002495135395057179,"y":0.02066081419152175},"radius":10,"mass-inv":1,"hash-code":579273066,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":120.49062812737513,"y":290.5785059141817},"velocity":{"x":0.0019718361736944584,"y":-0.0172336263353691},"radius":10,"mass-inv":1,"hash-code":290721463,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.07761980432872917,"hash-code":645178921,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.15441620354168747,"hash-code":645486523,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.23121260275464584,"hash-code":1063923080,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.30800900196760417,"hash-code":937701037,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.3848054011805625,"hash-code":991061825,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.46160180039352083,"hash-code":20953217,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.5383981996064792,"hash-code":638065474,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.6151945988194374,"hash-code":560011840,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.6919909980323957,"hash-code":391888879,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.768787397245354,"hash-code":58327050,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.8455837964583124,"hash-code":767381598,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":825919030,"b":672485740,"f":0.9223801956712708,"hash-code":309161777,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":672485740,"b":579273066,"f":0.25925032993838476,"hash-code":350633097,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":672485740,"b":579273066,"f":0.5,"hash-code":977890077,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":672485740,"b":579273066,"f":0.7407496700616152,"hash-code":743759298,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.07761980432872917,"hash-code":496844109,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.15441620354168747,"hash-code":265901511,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.23121260275464584,"hash-code":173223298,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.30800900196760417,"hash-code":853426921,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.3848054011805625,"hash-code":752298917,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.46160180039352083,"hash-code":749071572,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.5383981996064792,"hash-code":797854715,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.6151945988194374,"hash-code":85534656,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.6919909980323957,"hash-code":716938422,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.768787397245354,"hash-code":855077268,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.8455837964583124,"hash-code":777609885,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":579273066,"b":290721463,"f":0.9223801956712708,"hash-code":516372218,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":290721463,"b":825919030,"f":0.25925032993838476,"hash-code":659771513,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":290721463,"b":825919030,"f":0.5,"hash-code":98575655,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"metabody1d","a":290721463,"b":825919030,"f":0.7407496700616152,"hash-code":618071730,"group-name":"3d505b20-b420-11e3-997b-87f8712fdbbc"},{"type":"particle","position":{"x":152.40156320191977,"y":454.9746494595069},"velocity":{"x":0.04543134944220915,"y":0.00311978956924609},"radius":10,"mass-inv":1,"hash-code":404376724,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":227.4011029842068,"y":454.7123570785539},"velocity":{"x":0.04535017672349531,"y":-0.02117776183100136},"radius":10,"mass-inv":1,"hash-code":871883006,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":227.13881321103383,"y":379.71281676141757},"velocity":{"x":0.021052785189373525,"y":-0.02109669789097502},"radius":10,"mass-inv":1,"hash-code":769146799,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":152.13927173757577,"y":379.97510560779375},"velocity":{"x":0.021133660574718157,"y":0.0032008303462307316},"radius":10,"mass-inv":1,"hash-code":357921228,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":404376724,"b":871883006,"f":0.25555555555555554,"hash-code":114670823,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":404376724,"b":871883006,"f":0.5,"hash-code":324563748,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":404376724,"b":871883006,"f":0.7444444444444444,"hash-code":270012578,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":871883006,"b":769146799,"f":0.25555555555555554,"hash-code":108844928,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":871883006,"b":769146799,"f":0.5,"hash-code":318878998,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":871883006,"b":769146799,"f":0.7444444444444444,"hash-code":534814614,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":769146799,"b":357921228,"f":0.25555555555555554,"hash-code":484260524,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":769146799,"b":357921228,"f":0.5,"hash-code":60846790,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":769146799,"b":357921228,"f":0.7444444444444444,"hash-code":428121219,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":357921228,"b":404376724,"f":0.25555555555555554,"hash-code":733440685,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":357921228,"b":404376724,"f":0.5,"hash-code":709662093,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"metabody1d","a":357921228,"b":404376724,"f":0.7444444444444444,"hash-code":179097425,"group-name":"73b315e0-b420-11e3-ef87-ef51c7cb5ec6"},{"type":"particle","position":{"x":274.2275173176495,"y":454.7766771452381},"velocity":{"x":-0.053693614055648625,"y":0.000284802196496136},"radius":10,"mass-inv":1,"hash-code":8400022,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":374.225531855964,"y":454.14699808027484},"velocity":{"x":-0.05353254013259306,"y":0.025348837755601455},"radius":10,"mass-inv":1,"hash-code":863639107,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":373.75327504361445,"y":379.14848432620727},"velocity":{"x":-0.034734627572417104,"y":0.025228102035354968},"radius":10,"mass-inv":1,"hash-code":392011556,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":273.7552560788353,"y":379.7781626364701},"velocity":{"x":-0.034895446372561575,"y":0.00016403088773899854},"radius":10,"mass-inv":1,"hash-code":390587068,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":8400022,"b":863639107,"f":0.18,"hash-code":1056151777,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":8400022,"b":863639107,"f":0.34,"hash-code":692136009,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":8400022,"b":863639107,"f":0.5,"hash-code":976115836,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":8400022,"b":863639107,"f":0.66,"hash-code":717683251,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":8400022,"b":863639107,"f":0.82,"hash-code":617056521,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":863639107,"b":392011556,"f":0.25555555555555554,"hash-code":268753416,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":863639107,"b":392011556,"f":0.5,"hash-code":760096484,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":863639107,"b":392011556,"f":0.7444444444444444,"hash-code":285568642,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":392011556,"b":390587068,"f":0.18,"hash-code":878645622,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":392011556,"b":390587068,"f":0.34,"hash-code":901641226,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":392011556,"b":390587068,"f":0.5,"hash-code":197122705,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":392011556,"b":390587068,"f":0.66,"hash-code":820239112,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":392011556,"b":390587068,"f":0.82,"hash-code":869423559,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":390587068,"b":8400022,"f":0.25555555555555554,"hash-code":778824,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":390587068,"b":8400022,"f":0.5,"hash-code":354861612,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"metabody1d","a":390587068,"b":8400022,"f":0.7444444444444444,"hash-code":49425381,"group-name":"75bc5360-b420-11e3-d311-41ecfb89b420"},{"type":"particle","position":{"x":216.62614998965216,"y":548.147662172671},"velocity":{"x":-0.02284990699857715,"y":0.017405454426186934},"radius":10,"mass-inv":1,"hash-code":26731152,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":316.62539209413853,"y":548.5370532369286},"velocity":{"x":-0.02276303709027277,"y":-0.004299582545299984},"radius":10,"mass-inv":1,"hash-code":831662572,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":316.9174350219114,"y":473.5376216514507},"velocity":{"x":-0.03904180821620821,"y":-0.0043647339863274555},"radius":10,"mass-inv":1,"hash-code":113483240,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":216.91819360967622,"y":473.1482306543996},"velocity":{"x":-0.03912868804031781,"y":0.017340298437832274},"radius":10,"mass-inv":1,"hash-code":375769117,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":26731152,"b":831662572,"f":0.18,"hash-code":917552375,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":26731152,"b":831662572,"f":0.34,"hash-code":849293977,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":26731152,"b":831662572,"f":0.5,"hash-code":377392066,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":26731152,"b":831662572,"f":0.66,"hash-code":697025440,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":26731152,"b":831662572,"f":0.82,"hash-code":108614571,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":831662572,"b":113483240,"f":0.25555555555555554,"hash-code":541519741,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":831662572,"b":113483240,"f":0.5,"hash-code":467452331,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":831662572,"b":113483240,"f":0.7444444444444444,"hash-code":283422320,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":113483240,"b":375769117,"f":0.18,"hash-code":232346901,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":113483240,"b":375769117,"f":0.34,"hash-code":80158776,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":113483240,"b":375769117,"f":0.5,"hash-code":71542519,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":113483240,"b":375769117,"f":0.66,"hash-code":392733077,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":113483240,"b":375769117,"f":0.82,"hash-code":457768064,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":375769117,"b":26731152,"f":0.25555555555555554,"hash-code":173519834,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":375769117,"b":26731152,"f":0.5,"hash-code":927143667,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"metabody1d","a":375769117,"b":26731152,"f":0.7444444444444444,"hash-code":138750830,"group-name":"77e4ffc0-b420-11e3-96f6-1ddcc60f7dee"},{"type":"particle","position":{"x":658,"y":474},"velocity":{"x":-9.3,"y":-8.3},"radius":10,"mass-inv":1,"hash-code":250091412,"group-name":"e99a1650-0240-11e4-af29-7fa53652ae22"}],"constraints":[{"type":"distance","a":509015514,"b":417388204},{"type":"distance","a":417388204,"b":182352726},{"type":"distance","a":182352726,"b":149301034},{"type":"distance","a":149301034,"b":509015514},{"type":"distance","a":509015514,"b":182352726},{"type":"distance","a":417388204,"b":149301034},{"type":"distance","a":125604452,"b":516021118},{"type":"distance","a":516021118,"b":633354561},{"type":"distance","a":633354561,"b":374567880},{"type":"distance","a":374567880,"b":125604452},{"type":"distance","a":125604452,"b":633354561},{"type":"distance","a":516021118,"b":374567880},{"type":"distance","a":825919030,"b":672485740},{"type":"distance","a":672485740,"b":579273066},{"type":"distance","a":579273066,"b":290721463},{"type":"distance","a":290721463,"b":825919030},{"type":"distance","a":825919030,"b":579273066},{"type":"distance","a":672485740,"b":290721463},{"type":"distance","a":404376724,"b":871883006},{"type":"distance","a":871883006,"b":769146799},{"type":"distance","a":769146799,"b":357921228},{"type":"distance","a":357921228,"b":404376724},{"type":"distance","a":404376724,"b":769146799},{"type":"distance","a":871883006,"b":357921228},{"type":"distance","a":8400022,"b":863639107},{"type":"distance","a":863639107,"b":392011556},{"type":"distance","a":392011556,"b":390587068},{"type":"distance","a":390587068,"b":8400022},{"type":"distance","a":8400022,"b":392011556},{"type":"distance","a":863639107,"b":390587068},{"type":"distance","a":26731152,"b":831662572},{"type":"distance","a":831662572,"b":113483240},{"type":"distance","a":113483240,"b":375769117},{"type":"distance","a":375769117,"b":26731152},{"type":"distance","a":26731152,"b":113483240},{"type":"distance","a":831662572,"b":375769117}]}' ;

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
