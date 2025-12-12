(async () => {
    const token = localStorage.getItem("token");

    if (!token) {
        alert("Acesso negado!");
        window.location.href = "../index.html";
        return;
    }

    const response = await fetch("http://localhost:3000/teste", {
        headers: { "Authorization": token }
    });

    if (!response.ok) {
        alert("Sessão inválida ou expirada!");
        window.location.href = "../index.html";
    }
})();
