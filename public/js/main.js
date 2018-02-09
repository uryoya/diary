function signin() {
    const form = new FormData(document.querySelector('#signin-form'));
    const data = {
        "login": form.get('login'),
        "password": form.get('password'),
    };
    fetch('/api/signin', {
        method: 'post',
        credentials: 'include',
        body: JSON.stringify(data)
    })
        .then(function(resp) {
            if (resp.ok) {
                console.log("OK");
            } else {
                console.log(resp);
            }
        })
        .then(function(user) {
            console.log(user);
        });
}

function signout() {
    fetch('/api/signout', {
        method: "POST",
        credentials: 'include'
    })
    .then(function(resp) {
        console.log(resp.status);
    });
}

function createUser() {
    const data = {
        "login": document.getElementById('form-create-user-login').value,
        "name": document.getElementById('form-create-user-name').value,
        "accessToken": document.getElementById('form-create-user-atoken').value,
        "password": document.getElementById('form-create-user-password').value
    };
    fetch('/api/users', {
        method: "POST",
        credentials: 'include',
        body: JSON.stringify(data)
    })
    .then(function(resp) {
        console.log(resp);
        return resp.json();
    })
    .then(function(user) {
        console.log(user);
    });
}

function getUser() {
    const login_id = document.getElementById('form-login-id').value;
    fetch(`/api/users/${login_id}`, {
        credentials: 'include'
    })
    .then(function(resp) {
        return resp.json()
    })
    .then(function(user) {
        console.log(user)
    });
}
function getAllUser() { fetch('/api/users', { credentials: 'include'
    })
    .then(function(resp) {
        return resp.json()
    })
    .then(function(users) {
        console.log(users);
    });
}

function updateUser() {
    const login_id = document.getElementById('form-login-id').value;
    const form = new FormData(document.getElementById('update-user-form'));
    const data = {};
    if (form.get('name') !== '') data['name'] = form.get('name');
    if (form.get('access-token') !== '') data['access-token'] = form.get('access-token');
    if (form.get('password') !== '') data['password'] = form.get('password');
    console.log(data);
    fetch(`/api/users/${login_id}`, {
        credentials: 'include',
        method: 'put',
        body: JSON.stringify(data)
    })
    .then(function(resp) {
        return resp.json();
    })
    .then(function (user) {
       console.log(user);
    })
}

document.querySelector('#signin').addEventListener("click", signin);
document.querySelector('#signout').addEventListener('click', signout);
document.querySelector('#create-user').addEventListener('click', createUser);
document.querySelector("#get-user").addEventListener("click", getUser);
document.querySelector('#get-users').addEventListener('click', getAllUser);
document.querySelector('#update-user-button').addEventListener('click', updateUser);
