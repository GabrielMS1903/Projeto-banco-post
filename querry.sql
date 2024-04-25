CREATE TABLE time (
    id SERIAL PRIMARY KEY, 
    nome VARCHAR(26) NOT NULL, 
    posicao INT NOT NULL,
    pais VARCHAR(40) NOT NULL
);

INSERT INTO time (nome, posicao, pais) VALUES
('Flamengo', 1, 'Brasil'),
('São Paulo', 3, 'Brasil'),
('Palmeiras', 4, 'Brasil' ),
('Grêmio', 7, 'Brasil'),
('Internacional', 2, 'Brasil'),
('Atlético Mineiro', 6, 'Brasil' ),
('Corinthians', 5, 'Brasil'),
('Santos', 8, 'Brasil' ),
('Fluminense', 9, 'Brasil'),
('Cruzeiro', 10, 'Brasil'),
('Vasco da Gama', 11, 'Brasil'),
('Botafogo', 12, 'Brasil'),
('Paranaense', 13, 'Brasil'),
('Bahia', 14, 'Brasil'),
('Fortaleza', 15, 'Brasil'),
('Ceará', 16, 'Brasil'),
('Sport Recife', 17, 'Brasil'),
('Chapecoense', 18, 'Brasil');
SELECT * FROM time;

CREATE TABLE viagens (
    id SERIAL PRIMARY KEY,
    destino VARCHAR(40), 
    valor_viagem VARCHAR(40), 
    origem VARCHAR(40)
);

INSERT INTO viagens(destino, valor_viagem, origem) VALUES
('Paris', '19 mil reais', 'Brasil'), 
('Alemanha', '20 mil reais', 'Brasil'),
('México', '14 mil reais', 'Brasil'),
('Afeganistão', '22 mil reais', 'Brasil'),
('Portugal', '15 mil reais', 'Brasil'),
('Espanha', '18 mil reais', 'Brasil'),
('Egito', '17 mil reais', 'Brasil'),
('Estados Unidos', '20 mil reais', 'Brasil'),
('Japão', '25 mil reais', 'Brasil'),
('Austrália', '28 mil reais', 'Brasil'),
('Canadá', '23 mil reais', 'Brasil'),
('Itália', '21 mil reais', 'Brasil'),
('Grécia', '19 mil reais', 'Brasil'),
('Argentina', '16 mil reais', 'Brasil'),
('Chile', '16 mil reais', 'Brasil'),
('Colômbia', '15 mil reais', 'Brasil'),
('Suíça', '24 mil reais', 'Brasil'),
('Holanda', '22 mil reais', 'Brasil');
SELECT * FROM viagens;



CREATE TABLE departamento_medico (
    id SERIAL PRIMARY KEY,
    lesao VARCHAR(40), 
    repouso VARCHAR(40) 
);

INSERT INTO departamento_medico(lesao, repouso) VALUES
('Entorses', '6 semanas'), 
('Tendinites', '15 dias'), 
('Lesões na coxa', '8 semanas'), 
('Lesões no pé', '12 semanas'), 
('Fratura na perna', '3 meses'),
('Fratura no joelho', '1 mês'), 
('Esporão', '2 meses'), 
('Corte', '5 dias'),
('Torção no tornozelo', '4 semanas'),
('Luxação no ombro', '6 semanas'),
('Contusão no quadril', '3 semanas'),
('Lesão no ombro', '2 semanas'),
('Distensão muscular', '10 dias'),
('Lesão no tornozelo', '4 semanas'),
('Lesão no cotovelo', '3 semanas'),
('Lesão no punho', '2 semanas'),
('Lesão no joelho', '8 semanas'),
('Lesão na panturrilha', '4 semanas');
SELECT * FROM departamento_medico


CREATE TABLE jogador (
    id SERIAL PRIMARY KEY, 
    nome VARCHAR(70) NOT NULL, 
    idade INT, 
    fk_id_time INT not NULL, 
    fk_id_lesao INT not NULL, 
  	fk_id_viagens INT not NULL, 
    CONSTRAINT fk_time FOREIGN KEY (fk_id_time) REFERENCES time(id),
    CONSTRAINT fk_lesao FOREIGN KEY (fk_id_lesao) REFERENCES departamento_medico(id),
   	CONSTRAINT fk_viagens FOREIGN KEY (fk_id_viagens) REFERENCES viagens(id)
);

INSERT INTO jogador(nome, idade, fk_id_time, fk_id_lesao, fk_id_viagens) VALUES
('Alex Costa', 29, 1, 5, 2),
('Miguel Nogueira', 24, 3, 1, 1), 
('Felipe Nunes', 28, 1, 2, 3), 
('Antônio Silva', 31, 5, 5, 4), 
('Peres Roberto', 34, 4, 8, 5), 
('Guilherme Mailcon', 29, 6, 7, 6),
('Francisco Barros', 26, 2, 5, 8), 
('Brendo Maltes', 28, 2, 5, 7),
('Ricardo Santos', 25, 7, 3, 10),
('Lucas Oliveira', 27, 8, 4, 9),
('Pedro Henrique', 30, 9, 6, 8),
('Gustavo Lima', 26, 10, 7, 6),
('Matheus Pereira', 23, 11, 8, 5),
('Fernando Souza', 29, 12, 2, 4),
('Rodrigo Carvalho', 32, 13, 1, 3),
('Marcelo Silva', 27, 14, 3, 2),
('Leonardo Santos', 25, 15, 4, 1),
('Thiago Oliveira', 28, 16, 5, 10);
SELECT * FROM jogador;

--Consulta 
SELECT nome as nome_completo FROM jogador



SELECT * FROM jogador 
	JOIN departamento_medico
    on jogador.fk_id_lesao = departamento_medico.id
    WHERE lesao = 'Entorses'
    
SELECT * from jogador
	RIGHT join viagens
    on jogador.fk_id_viagens = viagens.id
    
SELECT * from jogador
	RIGHT join viagens
    on jogador.fk_id_viagens = viagens.id
    WHERE viagens.destino = 'Alemanha'
    
SELECT nome FROM time
	where nome LIKE '%Z%' OR nome like '%Cor%'
    
SELECT idade AS mais_velho from jogador 
	left JOIN time
    on jogador.fk_id_time = time.id
    WHERE idade > 28
    
    
SELECT valor_viagem from viagens
	WHERE valor_viagem = '33 mil reais' or valor_viagem = '19 mil reais'
  
  
SELECT nome from jogador
	join departamento_medico
    on jogador.fk_id_lesao = departamento_medico.id
    where repouso = '6 semanas' and lesao = 'Entorses'
    
SELECT jogador.nome from jogador 
	join time 
    on jogador.fk_id_time = time.id
    WHERE id = 1
    
SELECT jogador.nome FROM jogador
	left join time 
	ON jogador.fk_id_time = time.id
	where time.id = 1
    

-- Função para verificar a data de nascimento.
CREATE OR REPLACE FUNCTION calcular_nasc(idade INT)
RETURNS INT AS $$
DECLARE
    ano_nasc INT;
BEGIN
    ano_nasc := EXTRACT(YEAR FROM CURRENT_DATE) - idade;
    RETURN ano_nasc;
END;
$$ LANGUAGE plpgsql;

select idade, calcular_nasc(idade) from jogador