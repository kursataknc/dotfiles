# Global Instructions

## Obsidian Vault Senkronizasyonu

- **Vault konumu:** `~/My-Vault` (tüm cihazlarda)
- **Remote:** `git@github.com:kursataknc/My-Vault.git` (private)
- **Senkronizasyon:** git (Linux + Mac mini + MacBook Pro arası)

**Kural:** Kullanıcı oturum/çıkış belirten bir mesaj yazdığında (örn. "çıkış yapıyorum", "bilgisayarı kapatıyorum", "kapatacağım", "çıkıyorum", "logout", "bb") vault'ta değişiklik varsa:

1. `cd ~/My-Vault`
2. `git add -A`
3. Anlamlı bir commit mesajıyla commit at (Türkçe, kısa — örn: "yeni proje notu: X", "günlük not 2026-05-14")
4. `git push`

Değişiklik yoksa kullanıcıya "vault temiz" diye bildir, push atma.

**Cihaza ilk oturumda:** Vault'ta çalışmadan önce `cd ~/My-Vault && git pull` çalıştırılmalı (kullanıcı uyarılmalı veya otomatik çekilmeli).
