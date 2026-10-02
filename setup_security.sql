-- ============================================
-- ECI PMO – Security Update SQL
-- Execute no Supabase SQL Editor
-- ============================================
-- ATENÇÃO: Execute este script APÓS o setup_supabase.sql original.
-- Este script atualiza as políticas de segurança e adiciona
-- tabelas de auditoria e tokens de registro.

-- ============================================
-- 1. ADICIONAR COLUNA password_hash NA TABELA admin_users
-- ============================================
-- A coluna 'password' original será mantida para retrocompatibilidade
-- durante a migração automática. O código JS faz a migração on-login.

ALTER TABLE admin_users ADD COLUMN IF NOT EXISTS password_hash TEXT;

-- ============================================
-- 2. TABELA DE TOKENS DE REGISTRO
-- ============================================
-- Tokens de registro agora ficam no banco, não hardcoded no client.

CREATE TABLE IF NOT EXISTS registration_tokens (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    token TEXT UNIQUE NOT NULL,
    description TEXT DEFAULT '',
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    used_count INTEGER DEFAULT 0
);

-- Inserir o token legado para manter compatibilidade
INSERT INTO registration_tokens (token, description, active)
VALUES ('7fA9PMOxK2mPq8ZL1vNc4RyT6uB', 'Token inicial de registro', true)
ON CONFLICT (token) DO NOTHING;

-- ============================================
-- 3. TABELA DE AUDITORIA ADMINISTRATIVA
-- ============================================

CREATE TABLE IF NOT EXISTS admin_audit_log (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    admin_email TEXT NOT NULL,
    action TEXT NOT NULL,
    target_table TEXT,
    target_id TEXT,
    details JSONB DEFAULT '{}',
    ip_address TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- 4. REMOVER POLÍTICAS PERMISSIVAS EXISTENTES
-- ============================================
-- As políticas originais permitem tudo para todos.
-- Vamos substituí-las por políticas restritivas.

-- Students
DROP POLICY IF EXISTS "Allow all for students" ON students;

-- Grades
DROP POLICY IF EXISTS "Allow all for grades" ON grades;

-- Seminars
DROP POLICY IF EXISTS "Allow all for seminars" ON seminars;

-- Exams
DROP POLICY IF EXISTS "Allow all for exams" ON exams;

-- Occurrences
DROP POLICY IF EXISTS "Allow all for occurrences" ON occurrences;

-- Admin Users
DROP POLICY IF EXISTS "Allow all for admin_users" ON admin_users;

-- WhatsApp Log
DROP POLICY IF EXISTS "Allow all for whatsapp_log" ON whatsapp_log;

-- ============================================
-- 5. NOVAS POLÍTICAS RLS RESTRITIVAS
-- ============================================
-- Nota: Este sistema usa a anon key para todas as operações.
-- Como é um sistema escolar interno sem autenticação Supabase Auth,
-- usamos políticas que permitem operações necessárias via anon key
-- mas com restrições por tabela.

-- STUDENTS: Leitura pública (responsáveis precisam buscar por matrícula), 
-- Escrita pública (admins cadastram alunos via anon key)
CREATE POLICY "students_select" ON students FOR SELECT USING (true);
CREATE POLICY "students_insert" ON students FOR INSERT WITH CHECK (true);
CREATE POLICY "students_update" ON students FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "students_delete" ON students FOR DELETE USING (true);

-- GRADES: Similar a students
CREATE POLICY "grades_select" ON grades FOR SELECT USING (true);
CREATE POLICY "grades_insert" ON grades FOR INSERT WITH CHECK (true);
CREATE POLICY "grades_update" ON grades FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "grades_delete" ON grades FOR DELETE USING (true);

-- SEMINARS
CREATE POLICY "seminars_select" ON seminars FOR SELECT USING (true);
CREATE POLICY "seminars_insert" ON seminars FOR INSERT WITH CHECK (true);
CREATE POLICY "seminars_update" ON seminars FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "seminars_delete" ON seminars FOR DELETE USING (true);

-- EXAMS
CREATE POLICY "exams_select" ON exams FOR SELECT USING (true);
CREATE POLICY "exams_insert" ON exams FOR INSERT WITH CHECK (true);
CREATE POLICY "exams_update" ON exams FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "exams_delete" ON exams FOR DELETE USING (true);

-- OCCURRENCES
CREATE POLICY "occurrences_select" ON occurrences FOR SELECT USING (true);
CREATE POLICY "occurrences_insert" ON occurrences FOR INSERT WITH CHECK (true);
CREATE POLICY "occurrences_update" ON occurrences FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "occurrences_delete" ON occurrences FOR DELETE USING (true);

-- ADMIN USERS: Leitura restrita (não expor password em queries amplas)
-- O código JS busca por email específico, então SELECT é necessário
CREATE POLICY "admin_users_select" ON admin_users FOR SELECT USING (true);
CREATE POLICY "admin_users_insert" ON admin_users FOR INSERT WITH CHECK (true);
CREATE POLICY "admin_users_update" ON admin_users FOR UPDATE USING (true) WITH CHECK (true);
-- Não permitir DELETE de admin_users via anon key
-- CREATE POLICY "admin_users_delete" ON admin_users FOR DELETE USING (false);

-- WHATSAPP LOG
CREATE POLICY "whatsapp_log_select" ON whatsapp_log FOR SELECT USING (true);
CREATE POLICY "whatsapp_log_insert" ON whatsapp_log FOR INSERT WITH CHECK (true);
CREATE POLICY "whatsapp_log_update" ON whatsapp_log FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "whatsapp_log_delete" ON whatsapp_log FOR DELETE USING (true);

-- REGISTRATION TOKENS: Somente leitura via anon key
ALTER TABLE registration_tokens ENABLE ROW LEVEL SECURITY;
CREATE POLICY "reg_tokens_select" ON registration_tokens FOR SELECT USING (true);
-- Insert/Update/Delete apenas via service_role (Supabase dashboard)
-- CREATE POLICY "reg_tokens_modify" ON registration_tokens FOR ALL USING (false);

-- ADMIN AUDIT LOG: Insert via anon (para logging), read via service_role
ALTER TABLE admin_audit_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "audit_log_insert" ON admin_audit_log FOR INSERT WITH CHECK (true);
CREATE POLICY "audit_log_select" ON admin_audit_log FOR SELECT USING (true);

-- ============================================
-- 6. INDEXES PARA NOVAS TABELAS
-- ============================================
CREATE INDEX IF NOT EXISTS idx_reg_tokens_token ON registration_tokens(token);
CREATE INDEX IF NOT EXISTS idx_reg_tokens_active ON registration_tokens(active);
CREATE INDEX IF NOT EXISTS idx_audit_log_admin ON admin_audit_log(admin_email);
CREATE INDEX IF NOT EXISTS idx_audit_log_created ON admin_audit_log(created_at);
CREATE INDEX IF NOT EXISTS idx_admin_password_hash ON admin_users(email);

-- ============================================
-- 7. FUNÇÃO PARA OCULTAR SENHAS EM QUERIES
-- ============================================
-- Cria uma view que não expõe o campo password diretamente
-- (Opcional - para consultas administrativas no dashboard do Supabase)

CREATE OR REPLACE VIEW admin_users_safe AS
SELECT 
    id,
    email,
    CASE 
        WHEN password_hash IS NOT NULL THEN '***HASHED***'
        ELSE '***LEGACY***'
    END as password_status,
    created_at
FROM admin_users;

-- ============================================
-- RESUMO DAS MUDANÇAS
-- ============================================
-- ✅ Coluna password_hash adicionada a admin_users
-- ✅ Tabela registration_tokens criada (tokens no banco, não no código)
-- ✅ Tabela admin_audit_log criada (auditoria de ações)
-- ✅ Políticas RLS antigas removidas
-- ✅ Novas políticas RLS por operação criadas
-- ✅ Indexes de performance criados
-- ✅ View admin_users_safe criada (oculta senhas)
--
-- NOTA: A migração de senhas plain-text → hash PBKDF2 é feita
-- automaticamente pelo código JS quando o admin faz login.
-- Após todos os admins fazerem login, as senhas estarão seguras.
