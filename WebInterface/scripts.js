document.getElementById('Unlock').disabled = true;
document.getElementById('Lock').disabled = true;
const url1= "/Connect";
const url2= "/Unlock";
const url3= "/Lock";
function unlock() {
    fetch(url2, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({}),
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
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
        body: JSON.stringify({}),
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}


function connect() {
    fetch(url1, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({}),
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        document.getElementById('Unlock').disabled = false;
        document.getElementById('Lock').disabled = false;
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}





function changeSTS() {
  document.getElementById('mainSts').innerHTML = 'Connected ✔';
  document.getElementById('secondSts').innerHTML = 'Updated';
  document.getElementById('secondSts').style.color = 'green';
    if (document.getElementById('mainSts').innerHTML == 'Connected ✔') {
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



function closeForm() {
  document.getElementById("auth").style.display = "none";
}