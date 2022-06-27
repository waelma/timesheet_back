-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2022 at 07:11 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pointache`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `tache_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `comment`, `tache_id`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'hey', 49, NULL, NULL, 100),
(28, 'hello', 49, '2022-06-12 12:28:27', NULL, 28),
(29, 'we need to hurry up ', 49, '2022-06-12 12:28:59', NULL, 35),
(33, 'ok sir', 49, '2022-06-12 12:30:31', NULL, 100),
(47, 'slm', 9, '2022-06-13 15:42:13', NULL, 107),
(48, 'bnj', 9, '2022-06-13 16:10:36', NULL, 107),
(49, 'slm', 9, '2022-06-13 16:10:55', NULL, 35),
(50, 'hey', 7, '2022-06-20 13:59:44', NULL, 35);

-- --------------------------------------------------------

--
-- Table structure for table `confirmation_codes`
--

CREATE TABLE `confirmation_codes` (
  `code` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `confirmation_codes`
--

INSERT INTO `confirmation_codes` (`code`, `email`, `phone`) VALUES
(377802, 'waelma1920@gmail.com', NULL),
(711151, NULL, NULL),
(463797, NULL, '22222222'),
(379050, NULL, '29852436'),
(631562, NULL, '22207999'),
(660675, 'achlouchrabeb@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employes_projects`
--

CREATE TABLE `employes_projects` (
  `project_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employes_projects`
--

INSERT INTO `employes_projects` (`project_id`, `user_id`) VALUES
(10, 28),
(10, 100),
(10, 107);

-- --------------------------------------------------------

--
-- Table structure for table `employes_taches`
--

CREATE TABLE `employes_taches` (
  `tache_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employes_taches`
--

INSERT INTO `employes_taches` (`tache_id`, `user_id`) VALUES
(7, 28),
(7, 107),
(8, 100),
(9, 28),
(48, 100),
(49, 28),
(49, 100),
(78, 28),
(78, 107),
(79, 100),
(79, 107);

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(10) UNSIGNED NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tache_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `url`, `tache_id`) VALUES
(1, 'http://localhost:8000/uploads/files/1654963825specifications.pdf', 49),
(2, 'http://localhost:8000/uploads/files/1654967892st,small,507x507-pad,600x600,f8f8f8 (5).jpg', 48),
(3, 'http://localhost:8000/uploads/files/1654967927smartsheet.PNG', 48),
(4, 'http://localhost:8000/uploads/files/1655036131avancementProjet.txt', 49),
(5, 'http://localhost:8000/uploads/files/1655128253wael_cv.pdf', 9),
(7, 'http://localhost:8000/uploads/files/1655134889avancementProjet.txt', 9),
(8, 'http://localhost:8000/uploads/files/1655136805cahier.txt', 9),
(9, 'http://localhost:8000/uploads/files/1655428079classDiagram.jpg', 49),
(10, 'http://localhost:8000/uploads/files/1655733616cahier.txt', 7);

-- --------------------------------------------------------

--
-- Table structure for table `groupe_messages`
--

CREATE TABLE `groupe_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `project_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groupe_messages`
--

INSERT INTO `groupe_messages` (`id`, `message`, `date`, `project_id`, `user_id`) VALUES
(37, 'Hello team', '2022-06-17 12:00:30', 10, 107),
(38, 'Can anyone send me please the specifications ?', '2022-06-17 12:01:59', 10, 107),
(39, 'check yass', '2022-06-17 12:03:01', 10, 35),
(40, 'Hi Rabeb', '2022-06-17 12:04:00', 10, 100),
(41, 'I\'ll upload it for you', '2022-06-17 12:04:36', 10, 100);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `transmitter_id` int(10) UNSIGNED NOT NULL,
  `receiver_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `message`, `date`, `transmitter_id`, `receiver_id`) VALUES
(53, 'Salut je voudrais savoir comment ça marche le projet!!', '2022-06-17 01:22:41', 35, 100),
(54, 'Bonjour monsieur', '2022-06-17 01:24:39', 100, 35),
(55, 'Les statistiques montrent que nous nous en sortons très bien', '2022-06-17 01:25:04', 100, 35),
(56, 'nous prévoyons de terminer 3 jours avant le deadline', '2022-06-17 01:26:15', 100, 35),
(57, 'C\'est super, bon travail.', '2022-06-17 01:27:00', 35, 100),
(58, 'ok', '2022-06-17 01:28:35', 100, 35),
(59, 'ok', '2022-06-20 14:54:39', 35, 100),
(60, 'salut', '2022-06-20 14:55:27', 100, 35),
(61, 'bonjour', '2022-06-20 14:59:09', 35, 100);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2013_9_06_000000_create_users_table', 1),
(2, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(3, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(4, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(5, '2016_06_01_000004_create_oauth_clients_table', 1),
(6, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(13, '2022_03_19_174857_confirmation_codes', 1),
(14, '2022_04_05_092054_create_notifications_table', 2),
(15, '2022_03_04_215741_projects', 3),
(20, '2022_03_04_220004_employes_projects', 3),
(21, '2022_03_04_215855_taches', 4),
(22, '2022_03_04_215920_todos', 4),
(24, '2022_03_04_215951_employes_taches', 4),
(25, '2022_06_06_150429_comments', 5),
(26, '2022_06_08_005748_groupe_messages', 6),
(27, '2022_06_08_133834_messages', 7),
(28, '2022_06_11_155603_files', 8),
(30, '2022_06_11_175717_project_historys', 9),
(31, '2022_06_18_143824_add_soft_delete_to_projects_table', 10),
(33, '2022_06_18_144430_add_soft_delete_to_taches_table', 11);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('0803ef11-a6d3-49c2-8c1f-ad44987b094d', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task12 to test column in project 1\"}', '2022-06-13 12:56:19', '2022-06-13 12:56:13', '2022-06-13 12:56:19'),
('0f0ede12-dfe2-4959-8a6d-3eb296905ed2', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:28:09', '2022-06-16 23:26:16', '2022-06-16 23:28:09'),
('10f0ecfa-ac3d-49dd-841b-15d907eb2a29', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-13 01:33:13', '2022-06-13 01:33:06', '2022-06-13 01:33:13'),
('117a58ca-212c-4e07-ab19-8d2d64ea144e', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task3 in project 1\"}', '2022-06-13 15:09:58', '2022-06-13 15:09:48', '2022-06-13 15:09:58'),
('1abf5bbf-5318-427c-8172-38d5158690e0', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-17 10:03:31', '2022-06-16 23:27:01', '2022-06-17 10:03:31'),
('1d5b1170-6b21-41ec-af4b-212f51135f04', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":12,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task4 to test column in project 1\"}', '2022-06-13 01:04:04', '2022-06-13 01:03:54', '2022-06-13 01:04:04'),
('1e126513-9918-4323-bbdd-e8d8f87ac86d', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task2 in Khadamni\"}', '2022-06-17 00:11:44', '2022-06-16 23:42:04', '2022-06-17 00:11:44'),
('203e1e5e-8851-4f68-81bf-d38fd6e0d19e', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task Admin Dashboard to test column in Khadamni\"}', '2022-06-20 12:38:00', '2022-06-20 12:37:56', '2022-06-20 12:38:00'),
('22aec61a-fa0b-4df1-a191-d5549082862f', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":12,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task4 in project 2\"}', '2022-06-13 01:08:55', '2022-06-13 01:08:46', '2022-06-13 01:08:55'),
('288a63d7-0cbf-4ffb-9137-85e22f7f89fe', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task task12 to test column in Khadamni\"}', '2022-06-20 16:06:52', '2022-06-20 16:06:30', '2022-06-20 16:06:52'),
('2c7bb024-06d0-4b66-a0d0-100c1c723d1d', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-20 12:58:40', '2022-06-20 12:54:41', '2022-06-20 12:58:40'),
('34cbda0b-a3f0-4023-b42d-8117dcf7b78b', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task user profile to test column in Khadamni\"}', '2022-06-20 12:38:00', '2022-06-20 12:37:26', '2022-06-20 12:38:00'),
('360d8d63-e1ea-4995-86c6-868c3e3d609f', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-13 01:22:00', '2022-06-13 01:21:57', '2022-06-13 01:22:00'),
('3a3d3231-27bb-4a28-b358-4b997b8a6cdf', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":12,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task4 to test column in project 1\"}', '2022-06-13 01:04:41', '2022-06-13 01:04:36', '2022-06-13 01:04:41'),
('3b6640a2-6e19-43d8-bbbf-e226a9779f91', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:28:09', '2022-06-16 23:25:06', '2022-06-16 23:28:09'),
('3b95cb0b-1695-4c4b-b663-153f47ecd7f6', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task3 to test column in project 1\"}', '2022-06-16 18:30:51', '2022-06-15 22:43:59', '2022-06-16 18:30:51'),
('3c68b38a-f172-48ba-98b2-e885754d0149', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task user profile in Khadamni\"}', '2022-06-17 00:11:44', '2022-06-16 23:44:19', '2022-06-17 00:11:44'),
('45d88ce4-74ec-4408-bff8-b97e5483b428', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-13 13:02:31', '2022-06-13 13:02:28', '2022-06-13 13:02:31'),
('498532d0-758e-4107-9737-e8c8d3d28f2e', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-18 11:26:47', '2022-06-18 11:12:34', '2022-06-18 11:26:47'),
('4c4dc38a-4820-4623-9739-b7512ac0345c', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:03:26', '2022-06-16 23:03:11', '2022-06-16 23:03:26'),
('4d1ee383-16c2-4786-9677-fe524fc7d127', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":22,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task23 in Test\"}', '2022-06-13 01:09:27', '2022-06-13 01:09:19', '2022-06-13 01:09:27'),
('4da6c00a-bbc9-409f-84b0-b78fd6c878a2', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task2 in project 1\"}', '2022-06-13 01:22:25', '2022-06-13 01:22:21', '2022-06-13 01:22:25'),
('5622f96e-5f32-4d2f-be30-2acf3a43d216', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:10:28', '2022-06-16 23:10:20', '2022-06-16 23:10:28'),
('61264a8f-2667-4294-a0b1-ed9eaeb79bd7', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task SW3 in Khadamni\"}', '2022-06-16 23:30:22', '2022-06-16 23:30:10', '2022-06-16 23:30:22'),
('6533d8ea-ad08-4c76-badf-d8f3a71658f7', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:03:26', '2022-06-16 23:03:14', '2022-06-16 23:03:26'),
('6ade5380-d056-4b66-afe0-bfbd954a9489', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-13 14:18:08', '2022-06-13 14:17:58', '2022-06-13 14:18:08'),
('6cd22097-3a55-4689-861b-b98cde5f6a47', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task task3 to test column in Khadamni\"}', '2022-06-16 23:16:06', '2022-06-16 23:14:41', '2022-06-16 23:16:06'),
('6e34dc50-bd1e-49b6-91c8-fa03cce12e3b', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":107,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"sent you a message\"}', '2022-06-13 14:43:53', '2022-06-13 14:43:47', '2022-06-13 14:43:53'),
('6f100327-19e9-4e31-b29c-1533e9117f64', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"You send a message\"}', '2022-06-13 01:21:47', '2022-06-13 01:21:44', '2022-06-13 01:21:47'),
('71eed16e-2bd1-466e-abe0-6a699937bb72', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task3 to test column in project 1\"}', '2022-06-14 11:27:47', '2022-06-14 11:27:19', '2022-06-14 11:27:47'),
('7c791721-2a97-4429-9d4f-6bc0439c68c4', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task user profile to test column in Khadamni\"}', '2022-06-20 12:40:13', '2022-06-20 12:39:39', '2022-06-20 12:40:13'),
('7f55edd2-e202-4546-81d6-8d382b619d85', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task user profile to test column in Khadamni\"}', '2022-06-20 12:40:13', '2022-06-20 12:40:10', '2022-06-20 12:40:13'),
('813826bf-4ac0-4468-864e-762fa5fc3ea3', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task Admin Dashboard to test column in Khadamni\"}', '2022-06-16 23:16:06', '2022-06-16 23:14:11', '2022-06-16 23:16:06'),
('81aa45c6-079c-4f33-842c-5eb5352e1ec0', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task user profile in Khadamni\"}', '2022-06-16 23:31:51', '2022-06-16 23:31:47', '2022-06-16 23:31:51'),
('87013fda-bab1-4cb3-9020-0f21217beb6e', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task Admin Dashboard to test column in Khadamni\"}', '2022-06-20 12:58:21', '2022-06-20 12:58:17', '2022-06-20 12:58:21'),
('8bbf79e5-ed80-4b83-9612-7e1d7d678a36', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task3 to test column in project 1\"}', '2022-06-13 12:56:00', '2022-06-13 12:51:38', '2022-06-13 12:56:00'),
('91746bf1-b019-4fb9-ab0c-6fdb5ae7e170', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-16 23:22:48', '2022-06-16 23:22:43', '2022-06-16 23:22:48'),
('9845a325-2506-4f73-86e6-3edf0af5139c', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-16 23:10:53', '2022-06-16 23:10:48', '2022-06-16 23:10:53'),
('984a64aa-ef48-46c4-ab1d-aafd846dc2e5', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in project 1\"}', '2022-06-13 01:10:17', '2022-06-13 01:10:00', '2022-06-13 01:10:17'),
('984cb4e5-4448-4760-bb2e-4e959ea7a0ed', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task SW to test column in project 1\"}', '2022-06-16 18:30:51', '2022-06-15 22:43:00', '2022-06-16 18:30:51'),
('9853b4ea-b38e-45ca-9463-d10ff6aed40b', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-13 14:53:45', '2022-06-13 14:44:02', '2022-06-13 14:53:45'),
('9aaf2671-333e-4d4f-99ca-e4ae19a9fc38', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":107,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"You send a message\"}', '2022-06-13 12:57:38', '2022-06-13 12:57:33', '2022-06-13 12:57:38'),
('9c07504b-4218-4e01-89be-15403f4ccd56', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-18 11:26:47', '2022-06-18 11:11:24', '2022-06-18 11:26:47'),
('a2350073-7631-4efd-9049-5f968dfc2352', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":12,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task4 to test column in project 2\"}', '2022-06-13 01:33:45', '2022-06-13 01:33:42', '2022-06-13 01:33:45'),
('a918501f-be3f-46c9-ac73-7d3b7ee903f9', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-20 12:59:16', '2022-06-20 12:59:10', '2022-06-20 12:59:16'),
('a9bcfa2f-11e9-4231-ad60-bfbefee7972d', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-13 01:35:11', '2022-06-13 01:35:07', '2022-06-13 01:35:11'),
('ab1b0c70-a561-4a2d-8100-7e2f57447030', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"You send a message\"}', '2022-06-13 01:26:49', '2022-06-13 01:26:46', '2022-06-13 01:26:49'),
('b4ae5d2d-dcb0-4f28-af53-5116a28356f5', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task Admin Dashboard in Khadamni\"}', '2022-06-17 00:11:44', '2022-06-16 23:44:03', '2022-06-17 00:11:44'),
('b96c997f-0fd6-484d-8560-0ebdaf0bcd71', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:29:22', '2022-06-16 23:28:37', '2022-06-16 23:29:22'),
('c01f6e1f-07e9-48f9-b6e2-befcdf44406b', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 100, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:05:13', '2022-06-16 23:05:09', '2022-06-16 23:05:13'),
('c1bee913-3e55-4b90-b433-07bb0a724e95', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:09:04', '2022-06-16 23:08:55', '2022-06-16 23:09:04'),
('c1c7d4c0-b762-43fd-9d4e-62401f1b7bd6', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task task to test column in Khadamni\"}', '2022-06-16 23:16:06', '2022-06-16 23:14:44', '2022-06-16 23:16:06'),
('c5f0b6aa-a95e-40fd-a45e-46c77668a67b', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task3 in project 1\"}', '2022-06-13 12:49:39', '2022-06-13 12:49:35', '2022-06-13 12:49:39'),
('c88ab13d-e54c-4e14-a1a5-912145a464f1', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task3 to test column in project 1\"}', '2022-06-13 15:11:59', '2022-06-13 15:11:08', '2022-06-13 15:11:59'),
('cfb7baf2-4a23-4628-ac8c-64db9c61d3c9', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task task to test column in Khadamni\"}', '2022-06-16 23:04:32', '2022-06-16 23:03:37', '2022-06-16 23:04:32'),
('d201276c-d68e-4f8e-b3f9-4c19f57fa8e5', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-13 01:15:27', '2022-06-13 01:15:20', '2022-06-13 01:15:27'),
('da6fdb5e-f9f9-4095-aa7c-b282b63fe7c3', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"You send a message\"}', '2022-06-13 13:01:18', '2022-06-13 13:01:14', '2022-06-13 13:01:18'),
('dc1c3ca0-4d63-4b3f-b84b-21d0bfffb344', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":107,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"You send a message\"}', '2022-06-13 01:32:46', '2022-06-13 01:32:43', '2022-06-13 01:32:46'),
('de048edf-2611-4ba6-aceb-a694cc6dc56a', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in Test\"}', '2022-06-16 18:30:51', '2022-06-15 22:44:37', '2022-06-16 18:30:51'),
('deed3a41-c4ea-40cf-91da-007dd26aa7bb', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"You send a message\"}', '2022-06-13 12:58:27', '2022-06-13 12:57:53', '2022-06-13 12:58:27'),
('e04393ff-c5ed-4a27-b7dd-a9fdfb963480', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task task12 to test column in Khadamni\"}', '2022-06-16 23:16:24', '2022-06-16 23:16:18', '2022-06-16 23:16:24'),
('e0f36d4e-2f70-4f47-afbb-37a46d572779', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task3 to test column in project 1\"}', '2022-06-13 15:11:58', '2022-06-13 15:11:30', '2022-06-13 15:11:58'),
('e2b4030a-cae2-4b2f-bb69-c93bc0c02b2e', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-16 23:28:09', '2022-06-16 23:24:40', '2022-06-16 23:28:09'),
('eaaaff2b-8bc5-49eb-9b6f-e73b70f418fb', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":35,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"sent you a message\"}', '2022-06-13 15:15:13', '2022-06-13 15:15:08', '2022-06-13 15:15:13'),
('f5e9ac53-cebd-4367-b99d-9352ce26c20f', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":107,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"sent you a message\"}', '2022-06-14 11:27:47', '2022-06-13 15:15:26', '2022-06-14 11:27:47'),
('f69807ba-ebfc-4ae5-83a8-c3a69fb3903a', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"Moved task user profile to test column in Khadamni\"}', '2022-06-20 12:40:13', '2022-06-20 12:39:48', '2022-06-20 12:40:13'),
('f7b1b701-0890-4d6e-bdfa-322ddc90ba2f', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":10,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task Admin Dashboard to test column in Khadamni\"}', '2022-06-16 23:29:22', '2022-06-16 23:29:09', '2022-06-16 23:29:22'),
('f7c823d1-80fe-43f1-bb7a-78d6f3dfce8c', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":22,\"email\":\"machlouchrabeb@gmail.com\",\"firstName\":\"Rabeb\",\"lastName\":\"Machlouch\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1655076431Screenshot_20220421_010800.jpg\",\"content\":\"Moved task task23 to test column in project 1\"}', '2022-06-13 01:10:48', '2022-06-13 01:10:39', '2022-06-13 01:10:48'),
('fd1996a2-95aa-4bb7-9ecf-74ebd62ddce1', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 35, '{\"id\":100,\"email\":\"sugaryassmin23@gmail.com\",\"firstName\":\"Yassmin\",\"lastName\":\"Tlemsani\",\"photo\":\"https:\\/\\/lh3.googleusercontent.com\\/a-\\/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c\",\"content\":\"sent you a message\"}', '2022-06-20 12:58:21', '2022-06-20 12:55:28', '2022-06-20 12:58:21'),
('fd3866c7-2536-4ec9-81f9-89f5d6d42405', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task in Khadamni\"}', '2022-06-17 00:11:44', '2022-06-16 23:42:53', '2022-06-17 00:11:44'),
('feef4a31-ff14-4eda-8807-7fabd5535583', 'App\\Notifications\\EmployeeNotification', 'App\\Models\\User', 107, '{\"id\":10,\"email\":\"waelmachlouch@gmail.com\",\"firstName\":\"machlouch\",\"lastName\":\"wael\",\"photo\":\"http:\\/\\/localhost:8000\\/uploads\\/users\\/1652462116Screenshot_20220421_012359.jpg\",\"content\":\"assigned you to task task3 in project 1\"}', '2022-06-13 14:41:49', '2022-06-13 14:41:44', '2022-06-13 14:41:49');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('07a0164476c11dac106b2fc03a91f95132ad779646fc663a92223ee222de0ab8f866203e43dfbf30', 100, 9, '123', '[]', 0, '2022-06-17 10:03:22', '2022-06-17 10:03:22', '2023-06-17 11:03:22'),
('0c352147970a308023dd3e297930f35cbce67db97cf01a6f1959a5f3c7e6c274c7c2e3470193434d', 74, 9, '123', '[]', 0, '2022-04-28 14:31:19', '2022-04-28 14:31:19', '2023-04-28 15:31:19'),
('1828b4e5c41950b745bdf8dcda622f497767c93425a129181c72dc45f94944bff8d76dcffa4a9702', 60, 9, '123', '[]', 0, '2022-04-15 08:34:33', '2022-04-15 08:34:33', '2023-04-15 09:34:33'),
('1ab1feccf6f74860b0df4d159f17bb233fd708f831c6a67822520dbc90f14e3eb548b04f2b6be975', 9, 9, '123', '[]', 0, '2022-04-16 12:39:19', '2022-04-16 12:39:19', '2023-04-16 13:39:19'),
('1b2342504319808deffc2a9a67d90f5a274898c40c8123e81a32812baf2548f4ee33777b84755ba0', 102, 9, '123', '[]', 0, '2022-06-11 22:59:35', '2022-06-11 22:59:35', '2023-06-11 23:59:35'),
('1bdfa30c927ce27a96e935387263bdbba21c2ff4928d62f1792f28f662b9c603ab03fdba40a863f7', 107, 9, '123', '[]', 0, '2022-06-15 22:42:28', '2022-06-15 22:42:28', '2023-06-15 23:42:28'),
('1e01d179cd53dce6bacac3551d8445c8cefc1abb20989268435656fdb6a856631dfda31c8fef2ed2', 64, 9, '123', '[]', 0, '2022-04-28 00:36:59', '2022-04-28 00:36:59', '2023-04-28 01:36:59'),
('1e15fac8be0e2699a9b71e1e6ef5bd7c7ef16fafb7002e9f9fdbbde444d9cf6a00c1044d760b6e11', 107, 9, '123', '[]', 0, '2022-06-13 15:09:24', '2022-06-13 15:09:24', '2023-06-13 16:09:24'),
('26de1916b0b83e5a99d99a57d3436bf5493fc11861d9e0a9223911d9301e13ddd5d0fbf7bf2cf720', 9, 9, '123', '[]', 0, '2022-05-11 08:42:15', '2022-05-11 08:42:15', '2023-05-11 09:42:15'),
('2d55eb90fb744d32abc38e46f945c32c7c78689eda5c589c6048082e48a3ebdbb711bfa9c6804ac7', 104, 9, '123', '[]', 0, '2022-06-11 23:03:06', '2022-06-11 23:03:06', '2023-06-12 00:03:06'),
('2e023a0826bcd40d228fd0255a5951667ed533fc730def11f2cc29fcc7414009d01982aa479040c7', 97, 9, '123', '[]', 0, '2022-05-27 21:42:41', '2022-05-27 21:42:41', '2023-05-27 22:42:41'),
('31db4d1c60826d9b8f41aac40c01fc665ec20f916ec536ba2e7c1ca5febcdf744b018542de6094f6', 59, 9, '123', '[]', 0, '2022-04-14 23:15:00', '2022-04-14 23:15:00', '2023-04-15 00:15:00'),
('36b0378da4f0bd35b434cd7c2e4744d7244aad970f69f644802eaed752c0e8f7ebf7247555901cbe', 9, 9, '123', '[]', 0, '2022-04-14 20:34:37', '2022-04-14 20:34:37', '2023-04-14 21:34:37'),
('38872050c7ba79bd77f1b62126090649097da3a8e58c7da37d7b4c6cb1cd6ba763072e2d3c93959c', 77, 9, '123', '[]', 0, '2022-05-08 01:04:42', '2022-05-08 01:04:42', '2023-05-08 02:04:42'),
('3eb29dc7ff489f8b54ed3213c27ad8ef341c4126532ccd19e4fc17f040acf0fb636f0b63af8696cb', 60, 9, '123', '[]', 0, '2022-04-15 08:57:10', '2022-04-15 08:57:10', '2023-04-15 09:57:10'),
('3f6cc987a3604be48b6df37fdaa7af25b0fcb5901508b7caa28f560f61b7a15abf966e9cee81ea21', 79, 9, '123', '[]', 0, '2022-05-08 01:06:11', '2022-05-08 01:06:11', '2023-05-08 02:06:11'),
('41af76f0a4ff21997c2270ab047d33a278bc3498430c41b048ea5eebc7b949c832e60d15d3b933c3', 61, 9, '123', '[]', 0, '2022-04-15 09:10:52', '2022-04-15 09:10:52', '2023-04-15 10:10:52'),
('44cfe0c968b5a189314d49f770e3c4f18d4d27b5e732949fb2c0bb74569aa5b8e78a3b5e18595911', 58, 9, '123', '[]', 0, '2022-04-14 22:52:49', '2022-04-14 22:52:49', '2023-04-14 23:52:49'),
('48d5cf4f9a924436d4ebf15f83745fad47d788ab2f30ba73c25d6c8ceb6736976c271f07ea60af42', 9, 9, '123', '[]', 0, '2022-06-14 11:41:37', '2022-06-14 11:41:37', '2023-06-14 12:41:37'),
('48e58f96cc4e03dd59e5b1d603e6a1409b86e589a07c239837a5d427087976ba949521cb481a76f9', 9, 9, '123', '[]', 0, '2022-04-15 08:21:57', '2022-04-15 08:21:57', '2023-04-15 09:21:57'),
('4d006d19aefbd428203f40014263418e15568a900a736eb841d8a0122f03b823eb7d02e156a1f7f1', 60, 9, '123', '[]', 0, '2022-04-15 08:23:28', '2022-04-15 08:23:28', '2023-04-15 09:23:28'),
('4dd4bf291d89c5096d38e865f823f99843e1bc351b0955bdfb9232d718bd40af79049483a6ea5bc4', 84, 9, '123', '[]', 0, '2022-05-08 01:16:59', '2022-05-08 01:16:59', '2023-05-08 02:16:59'),
('5023b0fb9d12192bf7abade3d51f3650ed4bb45ec48979b598d269c34802ee471e31fe66a8b5b790', 9, 9, '123', '[]', 0, '2022-05-27 21:45:46', '2022-05-27 21:45:46', '2023-05-27 22:45:46'),
('53e371fff027b1aa3cff8a8945efefd9e05d7a023a242262ad42cf4271d33e6fac91422f0a7ff69c', 59, 9, '123', '[]', 0, '2022-04-14 23:15:53', '2022-04-14 23:15:53', '2023-04-15 00:15:53'),
('56084e6f0683cb17e717a5d2d7889024a26ed0a4c55033f5c22b99d588342a9ee0b56b560cf1d66d', 59, 9, '123', '[]', 0, '2022-04-14 23:06:55', '2022-04-14 23:06:55', '2023-04-15 00:06:55'),
('5802cb4705e4a80d38fbecb0c01a98a6bb0560d083f0ec7921f3b1a05cd3a85e9165f17969a3c339', 71, 9, '123', '[]', 0, '2022-04-28 14:23:48', '2022-04-28 14:23:48', '2023-04-28 15:23:48'),
('5b68e1cfa89d1479253eba3bcaabe7fa6db146edaa22dd0e7c7f3ba7d0d8157407dd9840175ca70c', 89, 9, '123', '[]', 0, '2022-05-08 01:33:45', '2022-05-08 01:33:45', '2023-05-08 02:33:45'),
('5d41a66c3f60da7346a7fe0feef4f31b7db05d7c535910c754dbb9728c6e8a3c121d732550734867', 93, 9, '123', '[]', 0, '2022-05-27 21:37:45', '2022-05-27 21:37:45', '2023-05-27 22:37:45'),
('5eee18b752f001f8710156c66e99b0f86f6d51d32b07cfb68fe55b40fb6c0292a5ccbee194771e8d', 35, 9, '123', '[]', 0, '2022-05-09 19:27:38', '2022-05-09 19:27:38', '2023-05-09 20:27:38'),
('5fc9a6c540ef2ffb30113d858178dbda4ece25a04e10a30a4b2a5d7c8e444795a877999bb204a808', 98, 9, '123', '[]', 0, '2022-05-29 13:14:05', '2022-05-29 13:14:05', '2023-05-29 14:14:05'),
('631dd8d5ed24ed735706c5def1eea5b76db728102ef4275e89f8e662f59075f3f0de4a5f89972806', 35, 9, '123', '[]', 0, '2022-06-11 00:42:18', '2022-06-11 00:42:18', '2023-06-11 01:42:18'),
('637a5dd6008051dbdc0d154903bb65225dc9255cac81f9aa2d9bd2154e6f4f8a1ce4407a8cdd49b1', 88, 9, '123', '[]', 0, '2022-05-08 01:32:14', '2022-05-08 01:32:14', '2023-05-08 02:32:14'),
('651c968fdef14f776c72ecb658033f3c66fc8e02889a3afdb7e110a0da26b43048a4df236815f291', 28, 9, '123', '[]', 0, '2022-06-06 12:09:34', '2022-06-06 12:09:34', '2023-06-06 13:09:34'),
('67906b9a467718cf607beb82cea9740a21e5f8c409e499ccce0707c057071b11b3981ec6464aea76', 62, 9, '123', '[]', 0, '2022-04-16 12:43:33', '2022-04-16 12:43:33', '2023-04-16 13:43:33'),
('67e967447973f39b019c0a5b380b887f349d16252274348febf82a006337f920e07a47171b7a8cdb', 28, 9, '123', '[]', 0, '2022-06-05 22:54:28', '2022-06-05 22:54:28', '2023-06-05 23:54:28'),
('6d8c5088cc90c22a335effcaf6ad65fa0ad38d21ef9d1a0f0bf31157bf4c0dc8abf5caa8b5f0a808', 99, 9, '123', '[]', 0, '2022-05-29 20:52:21', '2022-05-29 20:52:21', '2023-05-29 21:52:21'),
('6e19204132ab43bf0dfbe205a5d339f85a0ed65deaaa271743f21321f50d5d31a48208980e77d95f', 9, 9, '123', '[]', 0, '2022-06-07 09:47:43', '2022-06-07 09:47:43', '2023-06-07 10:47:43'),
('6fed49058b714a7df32fb895e78b6fd2062eadedf7f8518b5955e2f3be9a075baaf2ea506529a0e4', 9, 9, '123', '[]', 0, '2022-04-14 22:49:31', '2022-04-14 22:49:31', '2023-04-14 23:49:31'),
('732aa4ce87768e775764e269ad03c911a33d491e984a59f62239e553b6edad24ae656ca635170792', 60, 9, '123', '[]', 0, '2022-04-15 08:49:17', '2022-04-15 08:49:17', '2023-04-15 09:49:17'),
('76aee5b078615850b8545ffd55b3b60f28704e27a5b246f68e49930e346464dfe4fc24c904949d8c', 71, 9, '123', '[]', 0, '2022-04-28 14:24:28', '2022-04-28 14:24:28', '2023-04-28 15:24:28'),
('799de4273cb0cbf355b1f6d0b8b0b080c1b7996b2b61c522da6b6221d2523d7407c7a1c52c05dfe6', 9, 9, '123', '[]', 0, '2022-04-16 16:17:45', '2022-04-16 16:17:45', '2023-04-16 17:17:45'),
('79e71a5bbbdecdc3906d106cd3e42773b132477f9a04ac0829e8e0d6ef73dd243000ea68dc7810cf', 35, 9, '123', '[]', 0, '2022-05-08 01:35:26', '2022-05-08 01:35:26', '2023-05-08 02:35:26'),
('7bbc08cc8872831be01bba92f18e34034d26b7049552e4d148a778b14a480e2b0a9e8daf73f21633', 60, 9, '123', '[]', 0, '2022-04-15 08:41:39', '2022-04-15 08:41:39', '2023-04-15 09:41:39'),
('80632d98f0a14ab3553c235b7d624fd9bc1b9ccd869503e76a8c71fa49ad52b1888904f3e5b57303', 100, 9, '123', '[]', 0, '2022-06-10 19:24:17', '2022-06-10 19:24:17', '2023-06-10 20:24:17'),
('83d4e31bb6e707df0de3a237f06329dbfc5f411fbbd06140764ca74bc4951b1f68fe25902bd1b77f', 59, 9, '123', '[]', 0, '2022-04-14 23:19:34', '2022-04-14 23:19:34', '2023-04-15 00:19:34'),
('851b8cd89fa609165e0b553b689e8b3d04c0c3752b11d45d11be0ee854365e824f1088dd6284d84e', 9, 9, '123', '[]', 0, '2022-04-28 14:33:28', '2022-04-28 14:33:28', '2023-04-28 15:33:28'),
('8614852d371a4ae92f97a0199087ebe17bbc39f715822090ac5dee5d420e28fe7fa039e33551b0c7', 9, 9, '123', '[]', 0, '2022-06-13 00:55:21', '2022-06-13 00:55:21', '2023-06-13 01:55:21'),
('869adc8a637f20ec2b12af17d374eca5ea276831c54c07aa89a49d977d0592a69088fdfa2b903d3b', 83, 9, '123', '[]', 0, '2022-05-08 01:16:04', '2022-05-08 01:16:04', '2023-05-08 02:16:04'),
('86fbcadbc2132683fe6e2b482a024a453a14bf4ba15143cb5079b9a0182bb3e4da686d9c57a78a7d', 59, 9, '123', '[]', 0, '2022-04-14 23:18:34', '2022-04-14 23:18:34', '2023-04-15 00:18:34'),
('8b03e810ed8182c68a965e90687c84880f5a3870585e980f3338837701a132625db1d418584952bb', 9, 9, '123', '[]', 0, '2022-06-12 19:05:11', '2022-06-12 19:05:11', '2023-06-12 20:05:11'),
('8c2e7afc376d6378fd1632643cbb753301e1570f28888670d0a44e38b5a06e45930981c1b9d36408', 71, 9, '123', '[]', 0, '2022-04-28 14:23:21', '2022-04-28 14:23:21', '2023-04-28 15:23:21'),
('8de1cd96400464831dc9b44fc0faca03ffdba95e49bef6578984ecf16b8ee847e8de80a8f89e98e5', 81, 9, '123', '[]', 0, '2022-05-08 01:12:32', '2022-05-08 01:12:32', '2023-05-08 02:12:32'),
('8f61f0d9985f67dbd91840a959b157b1d1b39c37a1b60ba687074076ea1ea7784a571597af89411d', 85, 9, '123', '[]', 0, '2022-05-08 01:17:46', '2022-05-08 01:17:46', '2023-05-08 02:17:46'),
('908944700bff3e4297002f09ffd27524e59f58eaccdb6a3ae494fa756558aa6cb9a1a184a66d08fb', 100, 9, '123', '[]', 0, '2022-06-18 13:59:58', '2022-06-18 13:59:58', '2023-06-18 14:59:58'),
('9ce38d69dd036fec1aa356cb78c7310a246f6152b47075fb535c3a46e635f2c9e5ae30985cc75510', 35, 9, '123', '[]', 0, '2022-06-18 22:55:23', '2022-06-18 22:55:23', '2023-06-18 23:55:23'),
('9d19f4616fa13f7797a66258def154020d36764a8b33f328a970e37d47be968aa6310d28e69f0c13', 106, 9, '123', '[]', 0, '2022-06-12 19:04:41', '2022-06-12 19:04:41', '2023-06-12 20:04:41'),
('9ed86b23615c6702692c5595ab8383c48d0c35d8de78cd0fe9a5c217574b4fadcdccc1d546be5154', 100, 9, '123', '[]', 0, '2022-06-19 22:05:26', '2022-06-19 22:05:26', '2023-06-19 23:05:26'),
('9feb7bc85df7d6793eacd86a54e1f03d4ec441500de6f07e9bd1a22d6889a5a05a8b423d7a2e1037', 86, 9, '123', '[]', 0, '2022-05-08 01:24:10', '2022-05-08 01:24:10', '2023-05-08 02:24:10'),
('a124cf9ee410089f8091906f410ba610c8d7dd43e93f8a3c017e58df166b00852aee99851bd8e45c', 28, 9, '123', '[]', 0, '2022-06-06 14:00:33', '2022-06-06 14:00:33', '2023-06-06 15:00:33'),
('a1403e46c7c1ccf2c835944078873b770afc561b3915ed03500493a7aa8d4c31114e1e60d9825e58', 9, 9, '123', '[]', 0, '2022-05-10 14:16:15', '2022-05-10 14:16:15', '2023-05-10 15:16:15'),
('a14410244bb207707970625cc13b92d59d84b9d7af1f6025ea41c11aa5dc3a0a022936371ca3fd4c', 82, 9, '123', '[]', 0, '2022-05-08 01:13:23', '2022-05-08 01:13:23', '2023-05-08 02:13:23'),
('a391eccdda5f1420385f4453d9340798c1f52868c8e9a2e4710314464451cd2a0f0d33c865f6ea5c', 9, 9, '123', '[]', 0, '2022-05-08 01:59:59', '2022-05-08 01:59:59', '2023-05-08 02:59:59'),
('a6babcad969b7f45a7b19f61147737d5e026b90d5f7999ce1b6d48c68bcfe1b1f80cb813b4846635', 35, 9, '123', '[]', 0, '2022-05-17 20:21:31', '2022-05-17 20:21:31', '2023-05-17 21:21:31'),
('a9b8734d46f1d0f77ba5f40b70bd422f7b7f60981515b20acc4ac63609673fe8952e1f3431132953', 100, 9, '123', '[]', 0, '2022-06-06 14:36:40', '2022-06-06 14:36:40', '2023-06-06 15:36:40'),
('ab2ce27f83e2b41908a32d99f9f0528755e06635726b018aad18ce2507e76d4d5b75a3c10f2a5b5c', 9, 9, '123', '[]', 0, '2022-04-28 13:38:20', '2022-04-28 13:38:20', '2023-04-28 14:38:20'),
('aceca95c8e14bad523b7150b53de6d992450bd72f2ec06d2152ac872e307f5ea28eff378c44cb399', 74, 9, '123', '[]', 0, '2022-04-28 14:31:08', '2022-04-28 14:31:08', '2023-04-28 15:31:08'),
('b13a86a268da59f9e98618cfeb9a0e66242f4e2a9caa95532f4d2e723a4e4e4548da559d38f438e9', 60, 9, '123', '[]', 0, '2022-04-15 08:35:25', '2022-04-15 08:35:25', '2023-04-15 09:35:25'),
('b3635b56d4c57ab2dd2737e7a17fc564513db32b38d64ee82bc9b0fc4bebcc888f4a0d712ae00eee', 9, 9, '123', '[]', 0, '2022-05-08 01:04:08', '2022-05-08 01:04:08', '2023-05-08 02:04:08'),
('bcc7d756d387759f0201393ebaaafcf709d951f51cb6e4e66040a2890aa926318774f76ec1edb131', 78, 9, '123', '[]', 0, '2022-05-08 01:05:13', '2022-05-08 01:05:13', '2023-05-08 02:05:13'),
('bdf6ffeac55bcdc6c52df90ae9844cc1a9386aae9805a88fea08165c513674c6c5e84f48625ef038', 9, 9, '123', '[]', 0, '2022-05-08 01:04:10', '2022-05-08 01:04:10', '2023-05-08 02:04:10'),
('beb4440582d4fa270b51eaafdfbe00420626bf4b14344feb03470cbe8bf082ce6c0bd826252aa068', 9, 9, '123', '[]', 0, '2022-05-09 18:14:30', '2022-05-09 18:14:30', '2023-05-09 19:14:30'),
('c1435dee3ec7ce74d3e44bf012fc4a61a098c1e42ebf99ed29f2d03348c059cd6b2bbfe10e4f8a22', 75, 9, '123', '[]', 0, '2022-04-28 14:34:43', '2022-04-28 14:34:43', '2023-04-28 15:34:43'),
('c64cd8bea594dcb81f136e6867c7a79a338048fd343a739b00222103b97e681a7092f1a3091ad42a', 35, 9, '123', '[]', 0, '2022-05-08 11:23:28', '2022-05-08 11:23:28', '2023-05-08 12:23:28'),
('c9db1dc63869c2194ae7c7232a8d9684950bdd29506cfbc8917c419ea842d0a003945467aff8e10f', 59, 9, '123', '[]', 0, '2022-04-14 23:20:50', '2022-04-14 23:20:50', '2023-04-15 00:20:50'),
('d10850073a712e48aaca46da0675125de544c222a19fce2fc3e31a63c983b3c5fac084bc8e13b0c7', 107, 9, '123', '[]', 0, '2022-06-14 11:26:13', '2022-06-14 11:26:13', '2023-06-14 12:26:13'),
('d64ef1d3b614c8e4dccf2befd38a1a1674f190b2f95575dd22f972c2fb21612847e9ed56ba90b652', 9, 9, '123', '[]', 0, '2022-04-28 14:21:24', '2022-04-28 14:21:24', '2023-04-28 15:21:24'),
('d904bfd74cc85685f3d848473fd3fdaae3f5f95190ae6b05f533817647352c3cf7776b8b69cd97c4', 57, 9, '123', '[]', 0, '2022-04-14 22:50:00', '2022-04-14 22:50:00', '2023-04-14 23:50:00'),
('dafcb1223edfc0dbdc98c999c7f333614797f1a081e8bf4aaab422687e7b697eb5140be7e4b8de49', 9, 9, '123', '[]', 0, '2022-04-28 14:35:28', '2022-04-28 14:35:28', '2023-04-28 15:35:28'),
('db9476676ae3ef2642bca1e353413dcee6a1f8e88b25c0205bdca0a78ee33e58a915c1650aaf01f1', 60, 9, '123', '[]', 0, '2022-04-15 08:31:41', '2022-04-15 08:31:41', '2023-04-15 09:31:41'),
('dd88cfe6923926db8f483be3de4038440de682afeb0d36dcea8af91c612facdb82c44a45dc5b9b19', 9, 9, '123', '[]', 0, '2022-05-11 08:31:41', '2022-05-11 08:31:41', '2023-05-11 09:31:41'),
('dd991c57ccfb284c8cf91633b00ddbcecafcbf729681f4dd3783d8de1b6b7e3e2343d9c28910def8', 60, 9, '123', '[]', 0, '2022-04-14 23:22:00', '2022-04-14 23:22:00', '2023-04-15 00:22:00'),
('e1259750f12e358b9b08764d9a8789a1df320fe800f6d3d9b74d7f16da79a45301ab864d02a35839', 80, 9, '123', '[]', 0, '2022-05-08 01:09:23', '2022-05-08 01:09:23', '2023-05-08 02:09:23'),
('e547f2f804f3b3f014441942f3f0279e0ca8fafafb6869f01b964ea825983e4efee81538c8528f85', 87, 9, '123', '[]', 0, '2022-05-08 01:28:49', '2022-05-08 01:28:49', '2023-05-08 02:28:49'),
('e994cf913fd27f628cf6137ed2173c6191adaea77bbb035cf99c8b7961d471c7a28932fcbe22dbdb', 60, 9, '123', '[]', 0, '2022-04-15 08:39:49', '2022-04-15 08:39:49', '2023-04-15 09:39:49'),
('eb91c7289f46c837829038c4e88288691ff72035f2e8e99211471616531c82679ab6bf30cd5581a1', 100, 9, '123', '[]', 0, '2022-06-06 13:07:33', '2022-06-06 13:07:33', '2023-06-06 14:07:33'),
('efc68de3cc636c1fd5d4e6cc59de328ef74d27b5a83d2b198b2888d321598421ebfe07b9762c490b', 35, 9, '123', '[]', 0, '2022-06-08 12:53:47', '2022-06-08 12:53:47', '2023-06-08 13:53:47'),
('fb1b38533762eb11c0ea7e040dd937139adab7d6aef912db09d8bd0dfc960e2dee6bce8e297df112', 9, 9, '123', '[]', 0, '2022-06-08 10:01:47', '2022-06-08 10:01:47', '2023-06-08 11:01:47');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 't85vGSOdtMigX0em4SOECHkRH43VSkrsrp7SPipf', NULL, 'http://localhost', 1, 0, 0, '2022-03-20 11:42:23', '2022-03-20 11:42:23'),
(2, NULL, 'Laravel Password Grant Client', '1o2WB5TGXHAUeWNRLm0WOVFUGM2SG5H3yYQQg3Is', 'users', 'http://localhost', 0, 1, 0, '2022-03-20 11:42:23', '2022-03-20 11:42:23'),
(3, NULL, 'Laravel Personal Access Client', 'mZuR4vz73vj5HneRhXQasBZzGuRK9p89yeiI7OJ4', NULL, 'http://localhost', 1, 0, 0, '2022-03-20 11:42:24', '2022-03-20 11:42:24'),
(4, NULL, 'Laravel Password Grant Client', 'mBBjdLblc41Y4XAGZVU6HObMhey8xU73G5rsG2nr', 'users', 'http://localhost', 0, 1, 0, '2022-03-20 11:42:24', '2022-03-20 11:42:24'),
(5, NULL, 'Laravel Personal Access Client', 'ZGuzawSLqkSitTjIpVA5ePg4WZBL2wtTrTymETYy', NULL, 'http://localhost', 1, 0, 0, '2022-03-20 11:42:25', '2022-03-20 11:42:25'),
(6, NULL, 'Laravel Password Grant Client', 'hkFYdZKCuaCovayl0QKxxRmX3Zb1ygB6ImFD4rHk', 'users', 'http://localhost', 0, 1, 0, '2022-03-20 11:42:26', '2022-03-20 11:42:26'),
(7, NULL, 'Laravel Personal Access Client', '36KAxhIGegdilr5OOF3SH6lt0Hc8mA6UG6cu2AxM', NULL, 'http://localhost', 1, 0, 0, '2022-03-20 11:42:42', '2022-03-20 11:42:42'),
(8, NULL, 'Laravel Password Grant Client', 'IxP28KHF7nLdwpaWEqKjHQDDX3wQQSbdlop9hR2Q', 'users', 'http://localhost', 0, 1, 0, '2022-03-20 11:42:42', '2022-03-20 11:42:42'),
(9, NULL, 'Laravel Personal Access Client', 'GEbnsY23T95sVJQALKTgDe82RrxjZKVmDIxRHU3U', NULL, 'http://localhost', 1, 0, 0, '2022-04-08 08:55:07', '2022-04-08 08:55:07'),
(10, NULL, 'Laravel Password Grant Client', 'VB4kxcrmpCAqy6C1QzlW5QRaEDL8YJdHsA6PMsen', 'users', 'http://localhost', 0, 1, 0, '2022-04-08 08:55:07', '2022-04-08 08:55:07');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-03-20 11:42:23', '2022-03-20 11:42:23'),
(2, 3, '2022-03-20 11:42:24', '2022-03-20 11:42:24'),
(3, 5, '2022-03-20 11:42:25', '2022-03-20 11:42:25'),
(4, 7, '2022-03-20 11:42:42', '2022-03-20 11:42:42'),
(5, 9, '2022-04-08 08:55:07', '2022-04-08 08:55:07');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `etat` enum('todo','inprogress','test','done') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'todo',
  `chefP_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `details`, `dateDebut`, `dateFin`, `etat`, `chefP_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(10, 'Khadamni', NULL, '2022-05-15', '2022-07-10', 'inprogress', 35, '2022-05-09 00:34:12', '2022-05-09 00:34:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `project_historys`
--

CREATE TABLE `project_historys` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_historys`
--

INSERT INTO `project_historys` (`id`, `name`, `date`, `project_id`) VALUES
(4, 'Create project', '2022-06-01 20:56:34', 10),
(43, 'Create user profile', '2022-06-17 00:35:25', 10),
(48, 'SW completed', '2022-06-17 00:40:18', 10);

-- --------------------------------------------------------

--
-- Table structure for table `taches`
--

CREATE TABLE `taches` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `etat` enum('todo','inprogress','test','done') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'todo',
  `project_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taches`
--

INSERT INTO `taches` (`id`, `name`, `details`, `dateDebut`, `dateFin`, `etat`, `project_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(7, 'task', NULL, '2022-06-09', '2022-06-13', 'todo', 10, NULL, NULL, NULL),
(8, 'task2', 'This is a description...', '2022-06-21', '2022-06-30', 'inprogress', 10, NULL, NULL, '2022-06-18 15:29:03'),
(9, 'task3', 'description dhvsdh', '2022-06-01', '2022-06-09', 'todo', 10, NULL, NULL, NULL),
(48, 'task12', 'bqvdsqvdvqdvkq', '2022-06-08', '2022-07-03', 'test', 10, '2022-06-04 20:17:02', '2022-06-04 20:17:02', NULL),
(49, 'Admin Dashboard', 'On this task we will build the admin\'s dashboard', '2022-06-23', '2022-07-04', 'test', 10, '2022-06-04 20:18:08', '2022-06-04 20:18:08', NULL),
(78, 'Admin Dashboard', NULL, '2022-06-23', '2022-06-28', 'test', 10, '2022-06-11 23:34:54', '2022-06-09 23:34:54', NULL),
(79, 'user profile', NULL, '2022-06-11', '2022-06-23', 'test', 10, '2022-06-09 23:35:25', '2022-06-11 23:35:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `todos`
--

CREATE TABLE `todos` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `tache_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `todos`
--

INSERT INTO `todos` (`id`, `name`, `verified`, `tache_id`, `created_at`, `updated_at`) VALUES
(17, '1', 1, 48, NULL, NULL),
(18, '2', 0, 48, NULL, NULL),
(19, '3', 0, 48, NULL, NULL),
(20, '1', 1, 9, NULL, NULL),
(21, '2', 0, 9, NULL, NULL),
(22, 'manipulate user\'s accounts', 1, 49, NULL, NULL),
(24, 'supervised the posts', 0, 49, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `firstName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'http://localhost:8000/uploads/users/photParDefault.jpeg',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `speciality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `email_verified_at`, `password`, `photo`, `phone`, `speciality`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(9, 'Wael', 'Machlouch', 'waelma1920@gmail.com', NULL, '$2y$10$/y.mLQN4.8Fao3cVYHOhoeU.SmURfayhy/ZqeCD2uOFvzENFJ0iQS', 'http://localhost:8000/uploads/users/1648629545st,small,507x507-pad,600x600,f8f8f8.u5.jpg', '22207999', 'fullstack developper', '3', NULL, '2022-03-27 17:06:18', '2022-03-27 17:06:18'),
(28, 'atoui', 'zahreddine', 'at.zahreddine@gmail.com', '2022-04-08 09:12:17', '$2y$10$42bEJJhhZizrrZHmMdfHSuW0I3AIIaLhFOgvOW.PZrUJgzhArREW.', 'http://localhost:8000/uploads/users/1654377626Screenshot_20220421_015803.jpg', NULL, 'chef d\'équipe', '1', NULL, '2022-04-06 22:00:53', '2022-04-06 22:00:53'),
(35, 'machlouch', 'wael', 'waelmachlouch@gmail.com', '2022-04-16 12:35:28', NULL, 'http://localhost:8000/uploads/users/1652462116Screenshot_20220421_012359.jpg', NULL, NULL, '2', NULL, '2022-04-08 11:31:40', '2022-04-08 11:31:40'),
(100, 'Yassmin', 'Tlemsani', 'sugaryassmin23@gmail.com', '2022-06-15 17:47:30', NULL, 'https://lh3.googleusercontent.com/a-/AOh14GiKBVnzlLGk7ulbVO2s5-OpJwkldnofA9a4NuVemg=s96-c', NULL, NULL, '1', NULL, '2022-05-29 21:06:48', '2022-05-29 21:06:48'),
(107, 'Rabeb', 'Machlouch', 'machlouchrabeb@gmail.com', '2022-06-12 19:05:36', NULL, 'http://localhost:8000/uploads/users/1655076431Screenshot_20220421_010800.jpg', NULL, NULL, '1', NULL, '2022-06-12 19:05:29', '2022-06-12 19:05:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_tache_id_foreign` (`tache_id`);

--
-- Indexes for table `employes_projects`
--
ALTER TABLE `employes_projects`
  ADD PRIMARY KEY (`project_id`,`user_id`),
  ADD KEY `employes_projects_user_id_foreign` (`user_id`);

--
-- Indexes for table `employes_taches`
--
ALTER TABLE `employes_taches`
  ADD PRIMARY KEY (`tache_id`,`user_id`),
  ADD KEY `employes_taches_user_id_foreign` (`user_id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `files_tache_id_foreign` (`tache_id`);

--
-- Indexes for table `groupe_messages`
--
ALTER TABLE `groupe_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupe_messages_user_id_foreign` (`user_id`),
  ADD KEY `groupe_messages_project_id_foreign` (`project_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_transmitter_id_foreign` (`transmitter_id`),
  ADD KEY `messages_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projects_chefp_id_foreign` (`chefP_id`);

--
-- Indexes for table `project_historys`
--
ALTER TABLE `project_historys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_historys_project_id_foreign` (`project_id`);

--
-- Indexes for table `taches`
--
ALTER TABLE `taches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taches_project_id_foreign` (`project_id`);

--
-- Indexes for table `todos`
--
ALTER TABLE `todos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `todos_tache_id_foreign` (`tache_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `groupe_messages`
--
ALTER TABLE `groupe_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `project_historys`
--
ALTER TABLE `project_historys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `taches`
--
ALTER TABLE `taches`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `todos`
--
ALTER TABLE `todos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_tache_id_foreign` FOREIGN KEY (`tache_id`) REFERENCES `taches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employes_projects`
--
ALTER TABLE `employes_projects`
  ADD CONSTRAINT `employes_projects_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employes_projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employes_taches`
--
ALTER TABLE `employes_taches`
  ADD CONSTRAINT `employes_taches_tache_id_foreign` FOREIGN KEY (`tache_id`) REFERENCES `taches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employes_taches_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_tache_id_foreign` FOREIGN KEY (`tache_id`) REFERENCES `taches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groupe_messages`
--
ALTER TABLE `groupe_messages`
  ADD CONSTRAINT `groupe_messages_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `groupe_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_transmitter_id_foreign` FOREIGN KEY (`transmitter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_chefp_id_foreign` FOREIGN KEY (`chefP_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_historys`
--
ALTER TABLE `project_historys`
  ADD CONSTRAINT `project_historys_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taches`
--
ALTER TABLE `taches`
  ADD CONSTRAINT `taches_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `todos`
--
ALTER TABLE `todos`
  ADD CONSTRAINT `todos_tache_id_foreign` FOREIGN KEY (`tache_id`) REFERENCES `taches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
