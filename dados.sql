-- Dados de exemplo para o banco de dados GreenCheck
-- Inserção de dados de teste

-- Inserir usuários
INSERT INTO users (name, email) VALUES
    ('João Silva', 'joao.silva@example.com'),
    ('Maria Santos', 'maria.santos@example.com'),
    ('Pedro Oliveira', 'pedro.oliveira@example.com'),
    ('Ana Costa', 'ana.costa@example.com')
ON CONFLICT (email) DO NOTHING;

-- Inserir projetos sustentáveis
INSERT INTO projects (name, description, category, user_id) VALUES
    ('Energia Solar Residencial', 'Instalação de painéis solares em residências', 'Energia', 1),
    ('Coleta Seletiva Comunitária', 'Programa de reciclagem para a comunidade local', 'Reciclagem', 2),
    ('Horta Urbana', 'Cultivo de alimentos orgânicos em espaço urbano', 'Agricultura', 3),
    ('Economia de Água', 'Sistema de captação e reuso de água da chuva', 'Água', 4),
    ('Transporte Sustentável', 'Incentivo ao uso de bicicletas e transporte público', 'Mobilidade', 1)
ON CONFLICT DO NOTHING;

-- Inserir métricas ambientais
INSERT INTO metrics (project_id, metric_type, value, unit) VALUES
    (1, 'energia_gerada', 450.50, 'kWh'),
    (1, 'co2_reduzido', 225.25, 'kg'),
    (2, 'residuos_reciclados', 1500.00, 'kg'),
    (2, 'participantes', 85.00, 'pessoas'),
    (3, 'alimentos_produzidos', 120.00, 'kg'),
    (3, 'area_cultivada', 50.00, 'm2'),
    (4, 'agua_economizada', 3500.00, 'litros'),
    (4, 'co2_reduzido', 15.50, 'kg'),
    (5, 'distancia_percorrida', 2500.00, 'km'),
    (5, 'co2_evitado', 450.00, 'kg')
ON CONFLICT DO NOTHING;
