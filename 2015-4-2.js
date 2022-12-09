key = "yzbqklnj"
i = 0
let loop
loop = setInterval(function() {
    for (let j = 0; j < 10000; j++) {
    	let prehash = key + i
    	let posthash = md5(prehash) //http://www.myersdaily.org/joseph/javascript/md5.js
        if (posthash.substring(0, 6) == "000000") {
            clearInterval(loop)
            break
        }
    	i++
    }
    console.log(i)
}, 1)
//i couldnt find a fast enough library in lua so either i switch to javascript or i wait 15 hours
