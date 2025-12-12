import express from "express";
import cors from "cors";
import jwt from "jsonwebtoken";
import { db } from "./db.js";

const app = express();
app.use(cors());
app.use(express.json());

const SECRET = "segredo123";


import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


app.use(express.static(path.join(__dirname, "../")));


app.post("/login", async (req, res) => {
    const { email, senha } = req.body;

    try {
        const [rows] = await db.execute(
            "SELECT * FROM usuarios WHERE email = ?",
            [email]
        );

        if (rows.length === 0) {
            return res.status(404).json({ erro: "Usuário não encontrado" });
        }

        const usuario = rows[0];
        const senhaCorreta = senha === usuario.senha;

        if (!senhaCorreta) {
            return res.status(401).json({ erro: "Senha incorreta" });
        }

        const token = jwt.sign(
            { id: usuario.usuario_id },
            SECRET,
            { expiresIn: "1h" }
        );

        res.json({ mensagem: "Login bem sucedido!", token });

    } catch (err) {
        res.status(500).json({ erro: err.message });
    }
});


app.get("/teste", (req, res) => {
    const token = req.headers.authorization;

    if (!token) return res.status(401).json({ erro: "Token ausente" });

    jwt.verify(token, SECRET, (err, decoded) => {
        if (err) return res.status(401).json({ erro: "Token inválido" });

        res.json({ mensagem: "Acesso liberado!", user: decoded });
    });
});

app.post("/cadastro", async (req, res) => {
    const { nome, email, senha } = req.body;

    try {
        
        const [existe] = await db.execute(
            "SELECT * FROM usuarios WHERE email = ?",
            [email]
        );

        if (existe.length > 0) {
            return res.status(400).json({ erro: "Email já cadastrado" });
        }

        
        await db.execute(
            "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)",
            [nome, email, senha]
        );

        res.json({ mensagem: "Usuário criado com sucesso!" });

    } catch (err) {
        res.status(500).json({ erro: err.message });
    }
    console.log("🔥 ROTA /recuperar CHAMADA:", req.body);

});

app.put("/recuperar", async (req, res) => {
    const { email, novaSenha } = req.body;

    try {
        
        const [rows] = await db.execute(
            "SELECT * FROM usuarios WHERE email = ?",
            [email]
        );

        if (rows.length === 0) {
            return res.status(404).json({ erro: "Email não encontrado" });
        }

        
        await db.execute(
            "UPDATE usuarios SET senha = ? WHERE email = ?",
            [novaSenha, email]
        );

        res.json({ mensagem: "Senha alterada com sucesso!" });

    } catch (err) {
        res.status(500).json({ erro: err.message });
    }
});


app.listen(3000, () =>
    console.log("🔥 Servidor rodando em http://localhost:3000")
);

