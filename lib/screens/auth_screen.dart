import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AuthScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const AuthScreen({
    super.key,
    required this.onLoginSuccess,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _rememberDevice = true;
  bool _isLoading = false;

  final _idController = TextEditingController(text: '2022-10842-VR');
  final _passwordController = TextEditingController(text: 'catsu2024pass');

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() => _isLoading = false);
        widget.onLoginSuccess();
      }
    });
  }

  void _handleGoogleSSO() {
    _idController.text = 'jm.matienzo@catsu.edu.ph';
    _handleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  // University Seal & Header
                  _buildHeader(context),
                  const SizedBox(height: 18),

                  // Authentication Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Segmented Mode Selector
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _isLogin = true),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 160),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: _isLogin
                                            ? AppColors.primaryContainer
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: _isLogin
                                            ? const [
                                                BoxShadow(
                                                  color: Color(0x18000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 1),
                                                )
                                              ]
                                            : null,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.lock,
                                            size: 15,
                                            color: _isLogin
                                                ? Colors.white
                                                : AppColors.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Student / Staff Login',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: _isLogin
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                              color: _isLogin
                                                  ? Colors.white
                                                  : AppColors.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _isLogin = false),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 160),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: !_isLogin
                                            ? AppColors.primaryContainer
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: !_isLogin
                                            ? const [
                                                BoxShadow(
                                                  color: Color(0x18000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 1),
                                                )
                                              ]
                                            : null,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_add,
                                            size: 15,
                                            color: !_isLogin
                                                ? Colors.white
                                                : AppColors.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Create Account',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: !_isLogin
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                              color: !_isLogin
                                                  ? Colors.white
                                                  : AppColors.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Academic Identifier
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'University WebMail / ID Number',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              Text(
                                'Official Portal',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      fontSize: 10,
                                      color: AppColors.primaryContainer,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _idController,
                            decoration: const InputDecoration(
                              hintText: 'e.g. 2022-10842-VR or user@catsu.edu.ph',
                              prefixIcon: Icon(Icons.badge, size: 20, color: AppColors.outline),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.verified_user, size: 13, color: AppColors.secondary),
                              const SizedBox(width: 4),
                              Text(
                                'Use authenticated @catsu.edu.ph credentials only',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      fontSize: 10.5,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Portal Password',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please contact CICT / OSA Registrar to reset credentials.'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppColors.primaryContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: '••••••••••••',
                              prefixIcon: const Icon(Icons.key, size: 20, color: AppColors.outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  size: 18,
                                  color: AppColors.outline,
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Remember Terminal
                          Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: _rememberDevice,
                                  activeColor: AppColors.primaryContainer,
                                  onChanged: (v) => setState(() => _rememberDevice = v ?? true),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember ID on this campus terminal',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Sign In Button
                          ElevatedButton.icon(
                            onPressed: _isLoading ? null : _handleSignIn,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    _isLogin ? Icons.lock : Icons.badge,
                                    size: 18,
                                  ),
                            label: Text(
                              _isLoading
                                  ? 'Authenticating Terminal...'
                                  : (_isLogin ? 'Sign In with University ID' : 'Register CATSU Account'),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deepForest,
                              foregroundColor: AppColors.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider(color: AppColors.borderSubtle)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'INSTITUTIONAL ACCESS',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.outline,
                                        letterSpacing: 0.8,
                                      ),
                                ),
                              ),
                              const Expanded(child: Divider(color: AppColors.borderSubtle)),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Google Workspace SSO
                          OutlinedButton.icon(
                            onPressed: _handleGoogleSSO,
                            icon: Container(
                              width: 18,
                              height: 18,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Text(
                                'G',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            label: const Text(
                              'CATSU Single Sign-On (Google Workspace)',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              backgroundColor: AppColors.surfaceContainerLow,
                              foregroundColor: AppColors.onSurface,
                              side: const BorderSide(color: AppColors.borderSubtle),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campus Security Protocol Advisory
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          size: 20,
                          color: AppColors.gold,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Campus Security Protocol',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Found high-value personal effects or academic items? Hand over custody to the OSA or Central Guardhouse immediately for formal recording.',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      height: 1.35,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Operational Footer
                  Text(
                    'Catanduanes State University • Virac, Catanduanes • Institutional Portal',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Property Verification & Recovery System v2.4',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          color: AppColors.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondaryContainer.withValues(alpha: 0.4),
          ),
          child: ClipOval(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA3fpPBKP8QSy0ovpLHD0Ja2s4D7HlPwuNBznePIgcokN7pBIk8LlygocVVZvoEQP2dKn4lWdqKMdgXX5a2S5SQ7VEY2nvosMm8TDHsOaeIKf4pZI5AYptqLhU34eSvSRVwtta3AP72Z4fJ12ie47AlfeY8Y6vig5MTMIMrE71klVWoXxHhhhZ60vR-3IdgTeBlQUpYVhxqxecwpM8Oqk8N95eGqPV8pTufaYAwwcY',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(
                Icons.account_balance,
                size: 36,
                color: AppColors.primaryContainer,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Catanduanes State University',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          'Office of Student Affairs & Campus Security Services',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: AppColors.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 28, height: 2, color: AppColors.gold),
            const SizedBox(width: 8),
            Text(
              "FIND WHAT'S LOST • RETURN WHAT'S FOUND",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
            ),
            const SizedBox(width: 8),
            Container(width: 28, height: 2, color: AppColors.gold),
          ],
        ),
      ],
    );
  }
}
