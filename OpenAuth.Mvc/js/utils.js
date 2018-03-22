
//把name/value的数组转为obj对象
function arrayToObj(array) {
    var result = {};
    for (var i = 0; i < array.length; i++) {
        var field = array[i];
        if (field.name in result) {
            result[field.name] += ',' + field.value;
        } else {
            result[field.name] = field.value;
        }
    }
    return result;
}