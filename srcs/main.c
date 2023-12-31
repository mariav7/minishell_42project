/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mflores- <mflores-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/14 01:56:18 by mflores-          #+#    #+#             */
/*   Updated: 2023/03/20 19:46:42 by mflores-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

static int	check_args(int ac)
{
	if (ac == 1)
		return (1);
	ft_putendl_fd(ERR_USAGE, STDERR_FILENO);
	return (0);
}

/**
	Checks line.
	On failure or exiting, returns NULL.
	If user presses enter and line is empty, continues reading a new line.
	If not empty, recovers the line and is added to history.
	//print_structs_debug(&p, 0);
*/
static void	check_line(t_prompt *p)
{
	int		ret;

	ret = 0;
	if (!p->line)
	{
		ft_putendl_fd(MSG_EXIT, STDOUT_FILENO);
		exit_shell(p, g_exit_code);
	}
	if (p->line[0] != '\0')
	{
		ret = parse_line(p);
		if (ret == 0)
		{
			ret = init_data(p);
			if (ret == 0)
				start_execute(p);
		}
		else if (g_exit_code != 130)
			g_exit_code = ret;
	}
	free_line(p);
}

static void	start_minishell(t_prompt *p)
{
	while (1)
	{
		setup_signal_handlers();
		p->p = get_prompt(p);
		if (!p->p)
			p->line = readline(DEFAULT_PROMPT);
		else
		{
			p->line = readline(p->p);
			free(p->p);
			p->p = NULL;
		}
		check_line(p);
	}
}

int	main(int ac, char **av, char **env)
{
	t_prompt		prompt;

	if (isatty(STDIN_FILENO) == 0)
	{
		ft_putendl_fd(HELL_NO, STDERR_FILENO);
		return (EXIT_SUCCESS);
	}
	if (!check_args(ac) || !init_prompt(&prompt, env))
		exit_shell(NULL, EXIT_FAILURE);
	(void)av;
	start_minishell(&prompt);
	exit_shell(&prompt, g_exit_code);
}
