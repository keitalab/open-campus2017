var WebmoWs = require('webmo-client-nodejs').ws
var motor = new WebmoWs("192.168.42.1")
var rotate_angle=1000;
var rotate_time=2000;//単位は「ms」
motor.onopen = () => {
  motor.rotate(rotate_angle)//webmoを「angle/s」で回転させる(angleは度数法)
　setTimeout(() => { motor.stop(); motor.close(); }, rotate_time)//rotate_time経ったら、回転が止まる
}