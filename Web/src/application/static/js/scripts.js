

document.getElementById('Unlock').disabled = true;
document.getElementById('Lock').disabled = true;
const url1= "/api/status";
const url2= "/unlock";
const url3= "/lock";
function unlock() {
    fetch(url2, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        changeSTS2();
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}

function lock() {
    fetch(url3, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        changeSTS3();
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}


function connect() {
    fetch(url1, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        changeSTS();
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}





function changeSTS() {
  document.getElementById('mainSts').innerHTML = 'Online ✔';
  document.getElementById('secondSts').innerHTML = 'Updated';
  document.getElementById('secondSts').style.color = 'green';
    if (document.getElementById('mainSts').innerHTML == 'Online ✔') {
      document.getElementById('Unlock').disabled = false;
      document.getElementById('Lock').disabled = false;
    }
  }




function changeSTS2() {
  document.getElementById('secondSts').innerHTML = 'unlocked';
  document.getElementById('secondSts').style.color = 'blue';
}

function changeSTS3() {
  document.getElementById('secondSts').innerHTML = 'locked';
  document.getElementById('secondSts').style.color = 'red';
}


setInterval(connect, 5000);



